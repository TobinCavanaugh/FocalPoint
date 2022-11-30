using System.Linq;
using DefaultNamespace;
using Player;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Serialization;

namespace Game
{
    public class GeneratorStartMiniGame : Interactable
    {
        #region Player

        private const string PLAYER_COMPONENTS = "Player";

        [SerializeField, FoldoutGroup(PLAYER_COMPONENTS)]
        private Camera _playerCamera;
        
        [SerializeField, FoldoutGroup(PLAYER_COMPONENTS)]
        private PlayerMovement _playerMovement;
        
        [SerializeField, FoldoutGroup(PLAYER_COMPONENTS)]
        private MeshRenderer _playerMesh;
        
        [SerializeField, FoldoutGroup(PLAYER_COMPONENTS)]
        private Light _playerFlashlight;
        
        [SerializeField, FoldoutGroup(PLAYER_COMPONENTS)]
        private GameObject _miniGameCamera;        

        #endregion

        #region AI

        private const string AI = "AI";

        [SerializeField, FoldoutGroup(AI)]
        private AIController _aiController;
        
        [SerializeField, FoldoutGroup(AI)]
        private Transform _aiTargetPos;        

        #endregion

        #region Generator Start

        private const string GENERATOR_START = "Generator Start";
        
        [SerializeField, FoldoutGroup(GENERATOR_START), FormerlySerializedAs("generatorStartEvent")]
        private UnityEvent _generatorStartEvent;
        
        [SerializeField, FoldoutGroup(GENERATOR_START), FormerlySerializedAs("particleSystems")]
        private ParticleSystem[] _generatorStartParticles;
        
        #endregion

        #region Minigame

        private const string MINIGAME = "Minigame";

        [SerializeField, FoldoutGroup(MINIGAME), FormerlySerializedAs("randomPosParent")]
        private Transform _randomPosParent;
        
        [SerializeField, FoldoutGroup(MINIGAME)] 
        private int _countToStart = 7;
        
        [SerializeField, FoldoutGroup(MINIGAME), ReadOnly]
        private int _curCount = 0;

        #endregion

        public override void Interact(PlayerPickerUpper ppu)
        {
            _ppu = ppu;
            ToggleSettings(true);
            NewRandomSpot();
        }

        /// <summary>
        /// True is in interaction, false is out of interaction 
        /// </summary>
        /// <param name="state"></param>
        private void ToggleSettings(bool state)
        {
            _playerMovement.canLook = !state;
            _playerMovement.canMove = !state;
            _ppu.enabled = !state;
            _playerCamera.enabled = !state;
            _miniGameCamera.SetActive(state);
            Cursor.visible = state;
            _playerMesh.enabled = !state;
            _playerFlashlight.enabled = !state;

            if (state)
            {
                Cursor.lockState = CursorLockMode.Confined;
            }
            else
            {
                Cursor.lockState = CursorLockMode.Locked;
            }
        }

        private void Update()
        {
            if (Input.GetKeyDown(PlayerInput.instance.exitKey))
            {
                ToggleSettings(false);
            }
        }

        public void CordPulled()
        {
            //50 percent chance that wendigo comes a'runnin
            if (Random.Range(0, 100) > 50f)
            {
                _aiController.ExternalSetDestination(_aiTargetPos.position);
            }

            //Success
            if (_curCount >= _countToStart)
            {
                ToggleSettings(false);
                StartGenerator();
                return;
            }

            _curCount++;
            NewRandomSpot();
        }

        /// <summary>
        /// Generates a new random spot for the cable to be pulled to
        /// </summary>
        private void NewRandomSpot()
        {
            _randomPosParent.localPosition = new Vector3(Random.Range(-1, 1), Random.Range(-1.3f, -.5f), 0);
            //_randomPosParent.localEulerAngles = new Vector3(0, 0, Random.Range(70, 112));
        }

        private void StartGenerator()
        {
            _generatorStartParticles.ToList().ForEach(p => p.Play());
            _generatorStartEvent?.Invoke();
        }
    }
}
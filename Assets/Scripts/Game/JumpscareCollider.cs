using System.Collections;
using DG.Tweening;
using Player;
using UnityEngine;
using UnityEngine.UI;

namespace Game
{
    public class JumpscareCollider : MonoBehaviour
    {
        public Animator animator;
        public string jumpscareClip;

        public GameObject oldBody;
        public GameObject scareBody;

        public Transform spawnPos;
        private PlayerMovement _pm;
        
        public Transform teleportPos;

        public Image uiBlocker;
    
        [SerializeField] private AIController _aiController;

        private void OnTriggerEnter(Collider other)
        {
            if (other.gameObject.TryGetComponent(out PlayerMovement pm))
            {
                _pm = pm;
                StartCoroutine(JumpScare());
            }
        }

        public IEnumerator JumpScare()
        {
            ToggleSettings(true);

            animator.Play(jumpscareClip);

            yield return new WaitForSeconds(1.2f);

            uiBlocker.color = Color.black;
            
            ToggleSettings(false);

            _pm.transform.position = spawnPos.position;
            _aiController.ExternalSetDestination(_aiController.transform.position);

            _aiController.transform.position = teleportPos.position;

            yield return new WaitForSeconds(2);

            DOVirtual.Color(uiBlocker.color, Color.clear, 2f, c =>
            {
                uiBlocker.color = c;
            });
        }

        private void ToggleSettings(bool state)
        {
            oldBody.SetActive(!state);
            scareBody.SetActive(state);
            _pm.enabled = !state;
            _pm.rb.velocity = Vector3.zero;
            _aiController.enabled = !state;
        }
    }
}
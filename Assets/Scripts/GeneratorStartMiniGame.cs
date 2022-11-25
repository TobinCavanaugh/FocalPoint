using System.Linq;
using DefaultNamespace;
using UnityEngine;
using UnityEngine.Events;

public class GeneratorStartMiniGame : MonoBehaviour
{
    public Camera playerCamera;
    public PlayerMovement pm;
    public MeshRenderer mr;
    public Light lt;
    
    
    public GameObject miniGameCamera;

    private PlayerPickerUpper _ppu;

    public float chanceOfSuccess = 23f;

    public UnityEvent generatorStartEvent;
    public ParticleSystem[] particleSystems;

    public Transform randomPosParent;

    public Animator anim;
    public string animation = "spin";
    
    [SerializeField]
    private int countToStart = 7;
    private int curCount = 0;

    public void Interact(PlayerPickerUpper ppu)
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
        pm.canLook = !state;
        _ppu.enabled = !state;
        playerCamera.enabled = !state;
        miniGameCamera.SetActive(state);
        Cursor.visible = state;
        mr.enabled = !state;
        lt.enabled = !state;

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
        if (Input.GetButtonDown("Cancel"))
        {
            ToggleSettings(false);
        }
    }

    public void CordPulled()
    {
        curCount++;

        if (curCount >= countToStart)
        {
            Debug.Log("Success");
            ToggleSettings(false);
            StartGenerator();
            return;
        }
        
        // if (Random.Range(0, 100) <= chanceOfSuccess)
        // {
        //     Debug.Log("Success");
        //     ToggleSettings(false);
        //     StartGenerator();
        //     return;
        // }

        Debug.Log("Failure");
        NewRandomSpot();
    }

    private void NewRandomSpot()
    {
        randomPosParent.localEulerAngles = new Vector3(0, 0, Random.Range(70, 112));
    }

    private void StartGenerator()
    {
        particleSystems.ToList().ForEach(p => p.Play());
        generatorStartEvent?.Invoke();
        anim.Play(animation);
    }
}
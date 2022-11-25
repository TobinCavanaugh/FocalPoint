using UnityEngine;
using UnityEngine.EventSystems;

public class GeneratorPullCord : MonoBehaviour, IPointerEnterHandler, IPointerExitHandler
{
    public float multX = 1.5f;
    public float multY = 2f;

    public bool hovering = false;

    public Transform lerpSpot;
    public float lerpSpeed = 1f;

    public Transform triggerPos;
    public float triggerDistance;
    public AudioSource pullSource;

    private bool triggered = false;
    public GeneratorStartMiniGame gsmg;

    public Transform mesh;

    private void Update()
    {
        //If it hasnt been triggered and mouse is down
        if (Input.GetMouseButton(0) && !triggered)
        {
            if (hovering && !triggered)
            {

                Vector2 dat = Input.mousePosition;

                //Get dat as center of screen
                dat.x -= Screen.width / 2;
                dat.y -= Screen.height / 2;

                // Divide by screen width and height to get it between 0 and 1
                dat /= new Vector2(Screen.width, Screen.height);
                
                //Multiply by the corresponding screen dimension, divided by its corresponding 16:9 value, and multiply it by its mult
                //I got a confession, i got no clue how this works, but i found it by my sleep addled mind
                dat *= new Vector2(multX * (Screen.width / 16f), multY * (Screen.height / 9));
                
                transform.localPosition = dat;
                mesh.LookAt(new Vector3(lerpSpot.position.x, mesh.position.y, lerpSpot.position.z));
            }
        }
        else
        {
            //mesh.localEulerAngles = Vector3.Lerp(mesh.localEulerAngles, new(0,-90,-90), Time.deltaTime * lerpSpeed);
            mesh.localRotation = Quaternion.Lerp(mesh.localRotation, Quaternion.Euler(new(0, -90, -90)),
                Time.deltaTime * lerpSpeed * .01f);
            
            transform.position = Vector3.Lerp(transform.position, lerpSpot.position, Time.deltaTime * lerpSpeed);
            if (Vector3.Distance(transform.position, lerpSpot.position) < .05f)
            {
                triggered = false;
            }
        }
        
        //If right near the triggerpos
        if (Vector3.Distance(transform.position, triggerPos.position) <= triggerDistance && !triggered)
        {
            Debug.Log("distance");
            triggered = true;
            pullSource.Play();
            gsmg.CordPulled();
        }
        
        

    }

    public void OnPointerEnter(PointerEventData eventData)
    {
        hovering = true;
    }

    public void OnPointerExit(PointerEventData eventData)
    {
        hovering = false;
    }
}
using System;
using Newtonsoft.Json.Serialization;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Game
{
    public class GeneratorPullCord : MonoBehaviour, IPointerEnterHandler, IPointerExitHandler
    {
        private float aspectRatioMult = 1.5f;

        public bool hovering = false;

        public Transform lerpSpot;
        public float lerpSpeed = 1f;
        public float rotLerpSpeed = 25f;

        public Transform triggerPos;
        public float triggerDistance;
        public AudioSource pullSource;

        private bool triggered = false;
        public GeneratorStartMiniGame gsmg;

        public Transform mesh;

        public Canvas canvas;


        private RectTransform canvasRect;

        private void Start()
        {
            canvasRect = canvas.GetComponent<RectTransform>();
        }
        
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

                    dat *= new Vector2(Screen.width, Screen.height).normalized;

                    // Divide by screen width and height to get it between 0 and 1
                    dat /= new Vector2(Screen.width, Screen.height);

                    Debug.Log(Math.Round((double)Screen.width / Screen.height, 1));
                    
                    //This definitely is not ideal but i couldnt find an easier way to do this
                    //Based on the aspect ratio we set the sensitivity to pre-defined values
                    switch (Math.Round((double)Screen.width / Screen.height, 1))
                    {
                        //1:1 Aspect Ratio
                        case <= 1:
                            aspectRatioMult = 40; 
                            break;
                        //4:3 Aspect Ratio
                        case <= 1.3:
                            aspectRatioMult = 45;
                            break;
                        //16:9 Aspect Ratio
                        case <= 1.8:
                            aspectRatioMult = 55;
                            break;
                        //21:9 Aspect Ratio
                        case <= 2.3:
                            aspectRatioMult = 70;
                            break;
                        //32:9 Aspect ratio
                        case <= 3.6:
                            aspectRatioMult = 100;
                            break;
                    }
                    
                    //Multiply by the corresponding screen dimension, divided by its corresponding 16:9 value, and multiply it by its mult
                    //I got a confession, i got no clue how this works, but i found it by my sleep addled mind
                    dat *= new Vector2(aspectRatioMult, aspectRatioMult);
                    
                    dat.x *= canvasRect.rect.width;
                    dat.x *= canvasRect.localScale.x;

                    dat.y *= canvasRect.rect.height;
                    dat.y *= canvasRect.localScale.y;
                    
                    transform.localPosition = dat;
                    mesh.LookAt(new Vector3(lerpSpot.position.x, mesh.position.y, lerpSpot.position.z));
                }
            }
            else
            {
                //mesh.localEulerAngles = Vector3.Lerp(mesh.localEulerAngles, new(0,-90,-90), Time.deltaTime * lerpSpeed);
                mesh.localRotation = Quaternion.Slerp(mesh.localRotation, Quaternion.Euler(new(180, 90, -90)),
                    Time.deltaTime * rotLerpSpeed);

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
}
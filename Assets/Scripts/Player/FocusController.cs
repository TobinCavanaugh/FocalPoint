using System.Collections.Generic;
using DG.Tweening;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;
using UnityEngine.UI;

namespace DefaultNamespace
{
    public class FocusController : MonoBehaviour
    {
        public float sensitivity = 1f;
        public float maxFocusDistance = 50f;
        public float curFocusDistance = 1f;

        public float lerpSpeed = 1f;
        public PostProcessProfile ppp;
        private DepthOfField dof;

        public AudioClip clickClip;


        private List<AudioSource> sources = new();

        public int audioSourceCount = 15;

        [ReadOnly] public int index = 0;

        public bool inMainMenu = false;
        
        [ShowIf(nameof(inMainMenu))]
        public Image focusImage;

        private void Start()
        {
            dof = ppp.GetSetting<DepthOfField>();
            dof.focusDistance.value = 0;

            //Create audiosources
            for (int i = 0; i < audioSourceCount; i++)
            {
                var go = new GameObject($"{i} - ClickSound").transform;
                go.parent = this.transform;
                go.transform.localPosition = Vector3.zero;
                var source = go.gameObject.AddComponent<AudioSource>();
                source.clip = clickClip;
                sources.Add(source);
            }
        }

        private void Update()
        {
            //Get scroll values
            float scrollFac = Input.mouseScrollDelta.y;
            scrollFac += Input.GetAxis("FocusAxis") * .1f;
            scrollFac *= sensitivity;

            //Clamp and lerp the value and set the DOF
            curFocusDistance = Mathf.Clamp(curFocusDistance + scrollFac, 0, maxFocusDistance);
            dof.focusDistance.value = Mathf.Lerp(dof.focusDistance.value, curFocusDistance, Time.deltaTime * lerpSpeed);

            //If we is scrollin
            if (scrollFac != 0)
            {
                //Increment index and wrap its value around
                index++;
                if (index >= sources.Count)
                {
                    index = 0;
                }

                // Set the sound pitch. IDK how this works out mathematically, but it works :)
                sources[index].pitch = (curFocusDistance / maxFocusDistance + 1f) / 2f + .5f;
                sources[index].Play();
                
                
                if (inMainMenu)
                {
                    var v = DOVirtual.Color(focusImage.color, new Color(256,256,256,0), 2f, x =>
                    {
                        focusImage.color = x;
                    });
                    v.onComplete += () => { focusImage.gameObject.SetActive(false); };
                }
            }
        }
    }
}
using System;
using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace DefaultNamespace
{
    public class FocusController : MonoBehaviour
    {
        public float sensitivity = 1f;
        public float maxFocusDistance = 50f;
        public float curFocusDistance = 1f;

        public float lerpSpeed = 1f;
        public VolumeProfile ppp;
        private DepthOfField dof;

        public AudioClip clickClip;


        private List<AudioSource> sources = new();

        public int audioSourceCount = 15;
        
        [ReadOnly]
        public int index = 0;

        private void Start()
        {
            ppp.TryGet(out dof);
            
            for (int i = 0; i < audioSourceCount; i++)
            {
                var go = new GameObject().transform;
                go.parent = this.transform;
                go.transform.localPosition = Vector3.zero;
                var source = go.gameObject.AddComponent<AudioSource>();
                source.clip = clickClip;
                sources.Add(source);
            }
        }

        private void Update()
        {
            curFocusDistance += Input.mouseScrollDelta.y * sensitivity;

            curFocusDistance = Mathf.Clamp(curFocusDistance, 0, maxFocusDistance);
            dof.focusDistance.value = Mathf.Lerp(dof.focusDistance.value, curFocusDistance, Time.deltaTime * lerpSpeed);
            
            if (Input.mouseScrollDelta.y != 0)
            {
                index++;
                if (index >= sources.Count)
                {
                    index = 0;
                }
                
                sources[index].pitch = (curFocusDistance / maxFocusDistance + 1f) / 2f + .5f;
                sources[index].Play();
            }
        }
    }
}
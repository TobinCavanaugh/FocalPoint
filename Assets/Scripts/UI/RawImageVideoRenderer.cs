using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace UI
{
    [RequireComponent(typeof(RawImage))]
    public class RawImageVideoRenderer : MonoBehaviour
    {
        public List<Texture2D> textures;

        private RawImage _rawImage;

        public int fps = 60;

        private bool playing = true;

        [SerializeField]
        public bool Playing
        {
            get { return playing;}
            set
            {
                playing = true;
                StartCoroutine(Tick());
            }
        }
    
    
        private WaitForSeconds _waitForSeconds;
        private void Start()
        {
            _waitForSeconds = new WaitForSeconds(1f/fps);
            _rawImage = GetComponent<RawImage>();
            StartCoroutine(Tick());
        }

        private int index = 0;
        private IEnumerator Tick()
        {
            if (playing)
            {
                yield return null;
            }
        
            _rawImage.texture = textures[index];
            index++;

            if (index >= textures.Count)
            {
                index = 0;
            }
        
            yield return _waitForSeconds;
        
            StartCoroutine(Tick());
        }
    }
}
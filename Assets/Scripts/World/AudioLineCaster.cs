using UnityEngine;

namespace World
{
    [RequireComponent(typeof(AudioSource))]
    public class AudioLineCaster : MonoBehaviour
    {
        private static Transform cameraTransform;
        private AudioSource _audioSource;
        
        [SerializeField]
        private float _standardVolume;

        private LayerMask _layerMask;

        private float _lerpSpeed = .07f;
        
        // Start is called before the first frame update
        void Start()
        {
            _layerMask |= (1 << LayerMask.NameToLayer("Default")); 
            _audioSource = GetComponent<AudioSource>();
            cameraTransform = FindObjectOfType<AudioListener>().transform;
        }

        private void FixedUpdate()
        {
            float target = _standardVolume;
            
            //If being blocked by wall
            if (Physics.Linecast(cameraTransform.position, transform.position, _layerMask))
            {
                target = .2f;
            }

            //Lerp the volume
            _audioSource.volume = Mathf.Lerp(_audioSource.volume, target, .33f * _lerpSpeed);
        }
    }
}

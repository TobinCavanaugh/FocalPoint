using UnityEngine;

namespace DefaultNamespace
{
    public class WendigoAnimatorHelper : MonoBehaviour
    {
        public AudioSource roarSound;
        public void PlayRoarSound()
        {
            roarSound.Play();
            
        }


        public AudioSource stepSound;

        public void PlayStepSound()
        {
            stepSound.pitch = 1 + Random.Range(-.3f, .3f);
            stepSound.Play();
        }

        public ItemReactor ir;

        public void IncrementItemReactor()
        {
            ir.Increment();
        }
    }
}
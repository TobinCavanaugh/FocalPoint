using Game;
using UnityEngine;

namespace Utility
{
    public class AnimationEvents : MonoBehaviour
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

        public GeneratorFuelTank ir;

        public void IncrementItemReactor()
        {
            ir.Increment();
        }

        public void ResetXYZCoords()
        {
            transform.localPosition = Vector3.zero;
        }
    }
}
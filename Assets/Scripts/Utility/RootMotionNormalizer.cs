using System;
using UnityEngine;

namespace DefaultNamespace
{
    /// <summary>
    /// Basically just continually sets the x and z positions to 0, as well as setting the Y axis rotation to 0
    /// This is done to fix mixamo animations from getting stuck in incorrect animation positions from root motion
    /// </summary>
    public class RootMotionNormalizer : MonoBehaviour
    {
        private void LateUpdate()
        {
            var lea = transform.localEulerAngles;
            transform.localEulerAngles = new(lea.x, 0, lea.z);

            var tp = transform.localPosition;
            transform.localPosition = new(0, tp.y, 0);
        }
    }
}
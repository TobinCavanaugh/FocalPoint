using System;
using UnityEngine;

namespace DefaultNamespace
{
    public class ForceRotation : MonoBehaviour
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
using System;
using UnityEngine;

namespace DefaultNamespace
{
    public class LineRendererPositionioner : MonoBehaviour
    {
        public Transform start;
        public Transform other;
        public LineRenderer lr;

        private void Start()
        {
            lr.positionCount = 2;
            lr.useWorldSpace = true;
        }

        private void LateUpdate()
        {
            lr.SetPosition(0, start.position);
            lr.SetPosition(1, other.position);
        }
    }
}
using System;
using UnityEngine;

namespace DefaultNamespace
{
    public class PlayerInput : MonoBehaviour
    {
        public static PlayerInput instance;

        public KeyCode inputKey = KeyCode.E;
        public KeyCode exitKey = KeyCode.Escape;
        public KeyCode sprintKey = KeyCode.LeftShift;

        private void Awake()
        {
            if (instance is not null)
            {
                Destroy(instance);
            }
            else
            {
                instance = this;
            }
        }
    }
}
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace DefaultNamespace
{
    public class PlayerInput : MonoBehaviour
    {
        public static PlayerInput instance;

        public KeyCode inputKey = KeyCode.E;
        public KeyCode exitKey = KeyCode.Escape;
        public KeyCode sprintKey = KeyCode.LeftShift;
        public KeyCode dropKey = KeyCode.Q;

        public List<KeyCode> reloadKeys = new()
        {
            KeyCode.R,
            KeyCode.LeftControl
        };
        
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

        private void Update()
        {
            int keysPressed = 0;

            //Check for each key being pressed
            reloadKeys.ForEach(v => {
                if (Input.GetKey(v))
                {
                    keysPressed++;
                }}
            );
            
            //If each key is pressed
            if (keysPressed == reloadKeys.Capacity - 1)
            {
                SceneManager.LoadScene(1);
            }
        }
    }
}
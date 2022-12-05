using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace Player
{
    public class PlayerInput : MonoBehaviour
    {
        public static PlayerInput instance;

        public KeyCode inputKey = KeyCode.E;
        public KeyCode exitKey = KeyCode.Escape;
        public KeyCode sprintKey = KeyCode.LeftShift;
        public KeyCode dropKey = KeyCode.Q;

        public float focusSensitivity = 1f;
        public float mouseSensitivity = 1f;

        public void SetInputKey(string input)
        {
            input = input.ToUpper();
            input = input.Substring(0, 1);
            inputKey = Enum.Parse<KeyCode>(input);
        }

        public void SetDropKey(string input)
        {
            input = input.ToUpper();
            input = input.Substring(0, 1);
            dropKey = Enum.Parse<KeyCode>(input);
        }

        public void SetFocusSensitivity(float value)
        {
            focusSensitivity = value;
        }

        public void SetMouseSensitivity(float value)
        {
            mouseSensitivity = value;
        }
        
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
                DontDestroyOnLoad(this);
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
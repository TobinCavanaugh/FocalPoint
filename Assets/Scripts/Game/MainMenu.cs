using UnityEngine;

namespace Game
{
    public class MainMenu : MonoBehaviour
    {
        // Start is called before the first frame update
        void Start()
        {
            Cursor.lockState = CursorLockMode.Confined;
            Cursor.visible = true;
        }
    }
}

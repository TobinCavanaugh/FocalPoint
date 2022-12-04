using System.Collections;
using Player;
using UnityEngine;

namespace Game
{
    public class JumpscareCollider : MonoBehaviour
    {
        public Animator animator;
        public string jumpscareClip;

        public GameObject oldBody;
        public GameObject scareBody;

        public Transform spawnPos;
        private PlayerMovement _pm;

        public AIController controller;
    
        [SerializeField] private AIController _aiController;

        private void OnTriggerEnter(Collider other)
        {
            if (other.gameObject.TryGetComponent(out PlayerMovement pm))
            {
                _pm = pm;
                StartCoroutine(JumpScare());
            }
        }

        public IEnumerator JumpScare()
        {
            oldBody.SetActive(false);
            scareBody.SetActive(true);
            _pm.enabled = false;
            _pm.rb.velocity = Vector3.zero;
            controller.enabled = false;

            animator.Play(jumpscareClip);

            yield return new WaitForSeconds(1.2f);


            oldBody.SetActive(true);
            scareBody.SetActive(false);
            _pm.enabled = true;
            controller.enabled = true;
            _pm.transform.position = spawnPos.position;

            _aiController.SetDestinationToElevatorRoom();
        }
    }
}
using System.Collections;
using UnityEngine;

public class DripSoundPlacer : MonoBehaviour
{
    public AudioSource audioSource;


    public float minRandTime = 1f;
    public float maxRandTime = 3f;
    
    private LayerMask _lm = new LayerMask();
    private float _maxRandomPitch = 1.1f;
    private float _minRandomPitch = .9f;

    public ParticleSystem ps;

    private float distance = 0;

    private IEnumerator Start()
    {
        //These are the layers to drip on
        _lm |= (1 << LayerMask.NameToLayer("Default"));
        _lm |= (1 << LayerMask.NameToLayer("Water"));
        _lm |= (1 << LayerMask.NameToLayer("NotWalkable"));
        
        //Raycast down
        if (Physics.Raycast(audioSource.transform.position - new Vector3(0, 1, 0), Vector3.down, out var hit, 99f, _lm))
        {
            //Calculate the distance
            distance = Vector3.Distance(audioSource.transform.position - new Vector3(0, 1, 0), hit.point);
            
            audioSource.transform.position = hit.point;
        }
        else
        {
            Debug.Log("couldnt raycast");
        }
        
        yield return new WaitForSeconds(Random.Range(minRandTime, maxRandTime));
        StartCoroutine(S());
    }
    private IEnumerator S()
    { 
        //Play particle system
        ps.Play();

        //Dont play sound until particle has hit the ground based on gravity
        yield return new WaitForSeconds(distance / -9.81f);

        //Play sound with random pitch
        audioSource.Play();
        audioSource.pitch = Random.Range(_minRandomPitch, _maxRandomPitch);
        
        //Wait and then loop thur again
        yield return new WaitForSeconds(Random.Range(minRandTime, maxRandTime));
        StartCoroutine(S());
    }
}

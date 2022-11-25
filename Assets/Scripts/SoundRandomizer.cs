using System;
using System.Collections;
using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;
using Random = UnityEngine.Random;

public class SoundRandomizer : MonoBehaviour
{
    public AudioSource audioSource;

    public float maxRandomPitch = 1.1f;
    public float minRandomPitch = .9f;

    public float minRandTime = 1f;
    public float maxRandTime = 3f;
    
    private LayerMask lm = new LayerMask();

    public ParticleSystem ps;

    private float distance = 0;

    private IEnumerator Start()
    {
        //lm = LayerMask.NameToLayer("Default");

        lm |= (1 << LayerMask.NameToLayer("Default"));
        lm |= (1 << LayerMask.NameToLayer("Water"));
        lm |= (1 << LayerMask.NameToLayer("NotWalkable"));
        
        if (Physics.Raycast(audioSource.transform.position - new Vector3(0, 1, 0), Vector3.down, out var hit, 99f, lm))
        {
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
        ps.Play();

        yield return new WaitForSeconds(distance / -9.81f);

        audioSource.Play();
        audioSource.pitch = Random.Range(minRandomPitch, maxRandomPitch);

        yield return new WaitForSeconds(Random.Range(minRandTime, maxRandTime));
        
        StartCoroutine(S());
    }
}

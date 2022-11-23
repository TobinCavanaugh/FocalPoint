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

    private void Start()
    {
        //lm = LayerMask.NameToLayer("Default");

        lm |= (1 << LayerMask.NameToLayer("Default"));
        lm |= (1 << LayerMask.NameToLayer("Water"));
        lm |= (1 << LayerMask.NameToLayer("NotWalkable"));

            
        if (Physics.Raycast(audioSource.transform.position - new Vector3(0, 1, 0), Vector3.down, out var hit, 99f, lm))
        {
            audioSource.transform.position = hit.point;
        }
        else
        {
            Debug.Log("couldnt raycast");
        }
        
        
        StartCoroutine(S());
    }
    private IEnumerator S()
    {
        audioSource.Play();
        audioSource.pitch = Random.Range(minRandomPitch, maxRandomPitch);

        yield return new WaitForSeconds(Random.Range(minRandTime, maxRandTime));

        StartCoroutine(S());
    }
}

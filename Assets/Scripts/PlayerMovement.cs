using System.Collections;
using System.Collections.Generic;
using System.Runtime.Serialization.Json;
using UnityEngine;

public class PlayerMovement : MonoBehaviour
{
    //instance variables (tweak these to change the feel of the player controller)
    public float walkingSpeed = 5f;
    public float sprintingSpeed = 10f;
    public float mouseSens = 15f; //can change to be X and Y sens if wanted
    public float extraGravity = 0.3f;

    //don't change these unless you are seriously changing functionality
    private float currentSpeed;
    public float cameraXrotation = 0f;

    //references
    [HideInInspector]
    public Rigidbody rb;
    public Transform cameraHolder;

    //states
    bool isJumping = false;
    bool isGrounded = true;
    bool isCrouching = false;

    public float headBobAmplitude = 2f;
    public float headBobFrequency = 1f;
    public float headBobSprintMult = 2f;
    public float headBobLerpSpeed = 1f;

    public AudioSource stepAudio;

    public List<AudioClip> stepClips;

    public bool canLook = true;
    public bool canMove = true;


    //getting some references, locking the mouse, and setting some defualt values
    void Start()
    {
        rb = GetComponent<Rigidbody>();
        currentSpeed = walkingSpeed;
        cameraHolder.eulerAngles = new Vector3(0, 0, 0);
        Cursor.lockState = CursorLockMode.Locked;
    }

    Vector3 _newCameraPos = new(0, .45f, 0);

    public float minStepTriggerDist = .45f;
    private bool hitSide = false;

    void Update()
    {
        //handle keyboard and mouse input
        if (canMove)
            HandleKeys();

        if (canLook)
            LookAtMouse();

        //sprinting
        if (Input.GetKey(KeyCode.LeftShift) && !isJumping && !isCrouching)
        {
            currentSpeed = sprintingSpeed;
        }
        else if (!isCrouching && !isJumping)
        {
            currentSpeed = walkingSpeed;
        }

        float mult = 1f;

        //If not doing input
        if (input.x == 0 && input.z == 0)
        {
            //Dont do headbob
            mult = 0;
        }
        //Doing input
        else
        {
            //If sprinting, then apply sprinting speed
            if ((int) currentSpeed == (int) sprintingSpeed)
            {
                mult = headBobSprintMult;
            }
        }

        //Calculate the height
        float height = Mathf.Sin(Time.time * headBobFrequency * mult);

        //Set the newcamerapos
        _newCameraPos.y = height * headBobAmplitude + .45f;

        //If reaching bottom of sin wave
        if (height <= minStepTriggerDist)
        {
            //Sound hasnt been played yet
            if (hitSide)
            {
                //Play the sound
                stepAudio.pitch = Random.Range(.9f, 1.1f);
                stepAudio.clip = stepClips[Random.Range(0, stepClips.Count - 1)];
                stepAudio.Play();
                hitSide = false;
            }
        }
        else
        {
            hitSide = true;
        }

        //Lerp the position
        cameraHolder.localPosition = Vector3.Lerp(cameraHolder.localPosition, _newCameraPos,
            headBobLerpSpeed * Time.deltaTime * headBobLerpSpeed);

        //extra gravity for more realistic jumping
        rb.AddForce(new Vector3(0, -extraGravity, 0), ForceMode.Impulse);
    }

    private Vector3 input;

    //handling user input (wasd) for moving
    void HandleKeys()
    {
        input = new Vector3(Input.GetAxisRaw("Horizontal"), 0, Input.GetAxisRaw("Vertical"));
        input = input.normalized;
        Vector3 forwardVel = transform.forward * currentSpeed * input.z;
        Vector3 horizontalVel = transform.right * currentSpeed * input.x;
        rb.velocity = horizontalVel + forwardVel + new Vector3(0, rb.velocity.y, 0);
    }

    //look at mouse
    void LookAtMouse()
    {
        float mouseX = Input.GetAxis("Mouse X") * Time.deltaTime * Mathf.Rad2Deg;
        float mouseY = Input.GetAxis("Mouse Y") * Time.deltaTime * Mathf.Rad2Deg;

        if (mouseX == 0)
        {
            mouseX = Input.GetAxis("HorizontalKeeb") * Time.deltaTime * Mathf.Rad2Deg;
        }

        if (mouseY == 0)
        {
            mouseY = -Input.GetAxis("VerticalKeeb") * Time.deltaTime * Mathf.Rad2Deg;
        }


        transform.Rotate(transform.up * mouseX * mouseSens);

        cameraXrotation -= mouseY * mouseSens;
        //change these two values for however much you want to clamp looking up and down.
        cameraXrotation = Mathf.Clamp(cameraXrotation, -61f, 90f);
        cameraHolder.localRotation = Quaternion.Euler(cameraXrotation, 0f, 0f);
    }

    //ground check
    //* make sure whatever you want to be the ground in your game matches the tag below called "Ground" or change it to whatever you want
    private void OnCollisionEnter(Collision other)
    {
        if (other.gameObject.tag == "Ground")
        {
            currentSpeed = walkingSpeed;
            isJumping = false;
            isGrounded = true;
        }
    }
}
 [SerializeField] private LayerMask platformsLayerMask;
    public Rigidbody rb;
    public float speed = 5;
    public Transform cam;
    public float jumpVelocity = 0.2f;
    public Collider col;
    private float jumpTimeCounter;
    private bool isJumping;
    public float jumptime = 0.1f;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        Vector3 m_Input = new Vector3(Input.GetAxis("Horizontal"), 0, Input.GetAxis("Vertical"));
        
        float horizontal = Input.GetAxis("Horizontal");
        float vertical = Input.GetAxis("Vertical");
        Vector3 camF = cam.forward;
        Vector3 camR = cam.right;

        camF.y = 0;
        camR.y = 0;
        camF = camF.normalized;
        camR = camR.normalized;
        rb.MovePosition(transform.position + (camF * m_Input.z + camR * m_Input.x) * Time.deltaTime * (speed * 10) );
     
        if (Input.GetKeyDown(KeyCode.Space) && isGrounded())
        {
            isJumping = true;
            jumpTimeCounter = jumptime;
            rb.AddForce(new Vector3(0, 100, 0) * jumpVelocity / 10, ForceMode.Impulse);
        }
        if (Input.GetKey(KeyCode.Space) && isJumping == true)
        {
            if (jumpTimeCounter > 0)
            {
                //rb.velocity = Vector2.up * jumpVelocity;
                rb.AddForce(new Vector3(0, 100, 0) * jumpVelocity / 10, ForceMode.Impulse);
                jumpTimeCounter -= Time.deltaTime;
            }
            else
            {
                isJumping = false;
            }
        }
        Debug.Log(isGrounded());
        //transform.position += (camF * m_Input.y + camR * m_Input.x) * Time.deltaTime * speed;
    }
  private bool isGrounded()
    {
        return Physics.CheckCapsule(col.bounds.center, new Vector3(col.bounds.center.x, col.bounds.min.y - 0.1f, col.bounds.center.z), 0.18f, platformsLayerMask);
    }

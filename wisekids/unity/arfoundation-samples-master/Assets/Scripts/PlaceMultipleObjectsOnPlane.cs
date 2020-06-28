using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;

[RequireComponent(typeof(ARRaycastManager))]
public class PlaceMultipleObjectsOnPlane : MonoBehaviour
{
    /// <summary>
    /// /////////////////////////////////////////////////////////////////////////////////////////// charecter selected from flutter
    /// </summary>
    public static string selectedMainCharecter = "Cat";

    //////////////////////////////////////////////////////////////////// Scene1 Boy 
    [SerializeField]
    [Tooltip("Instantiates this prefab on a plane at the touch location.")]
    GameObject m_scene1BoyPrefab;
    public GameObject scene1BoyPrefab
    {
        get { return m_scene1BoyPrefab; }
        set { m_scene1BoyPrefab = value; }
    }
    //////////////////////////////////////////////////////////////////// Scene1 Girl
    [SerializeField]
    [Tooltip("Instantiates this prefab on a plane at the touch location.")]
    GameObject m_scene1GirlPrefab;
    public GameObject scene1GirlPrefab
    {
        get { return m_scene1GirlPrefab; }
        set { m_scene1GirlPrefab = value; }
    }
    //////////////////////////////////////////////////////////////////// Scene1 Cat
    [SerializeField]
    [Tooltip("Instantiates this prefab on a plane at the touch location.")]
    GameObject m_scene1CatPrefab;
    public GameObject scene1CatPrefab
    {
        get { return m_scene1CatPrefab; }
        set { m_scene1CatPrefab = value; }
    }
    



    public static bool objectPlaced = false;
    private GameObject placeObject;

    /*
    [SerializeField]
    [Tooltip("Instantiates this prefab on a plane at the touch location.")]
    GameObject m_scene1Prefab;
    /// <summary>
    /// The prefab to instantiate on touch.
    /// </summary>
    public GameObject scene1Prefab
    {
        get { return m_scene1Prefab; }
        set { m_scene1Prefab = value; }
    }
    */



    /// <summary>
    /// The object instantiated as a result of a successful raycast intersection with a plane.
    /// </summary>
    public static GameObject spawnedObject;//{ get; private set; }

    /// <summary>
    /// Invoked whenever an object is placed in on a plane.
    /// </summary>
    public static event Action onPlacedObject;

    ARRaycastManager m_RaycastManager;

    static List<ARRaycastHit> s_Hits = new List<ARRaycastHit>();

    public static Vector3 placedPosition;
    public static Quaternion placedRotation;

  
    void Awake()
    {
        
        

    }

    private void Start()
    {
       /*m_RaycastManager = GetComponent<ARRaycastManager>();
        if (selectedMainCharecter == "Boy")
        {
            placeObject = m_scene1BoyPrefab;

        }
        else if (selectedMainCharecter == "Girl")
        {
            placeObject = m_scene1GirlPrefab;

        }
        else if (selectedMainCharecter == "Cat")
        {
            placeObject = m_scene1CatPrefab;

        }*/
    }

    void Update()
    {

        if (Input.touchCount > 0 && !objectPlaced)
        {
            Touch touch = Input.GetTouch(0);

            if (touch.phase == TouchPhase.Began)
            {
                if (m_RaycastManager.Raycast(touch.position, s_Hits, TrackableType.PlaneWithinPolygon))
                {
                    
                    Pose hitPose = s_Hits[0].pose;
                    placedPosition = UIManager.placementPose.position;
                    placedRotation = UIManager.placementPose.rotation;
                    spawnedObject = Instantiate(placeObject, UIManager.placementPose.position, UIManager.placementPose.rotation);
                    objectPlaced = true;
                    UnityMessageManager.Instance.SendMessageToFlutter("Placed object");
                    if (onPlacedObject != null)
                    {
                        onPlacedObject();
                    }
                }
            }
        }
    }




void MainCharacterSelected(String messageFromFlutter)
{
        selectedMainCharecter = messageFromFlutter;

        m_RaycastManager = GetComponent<ARRaycastManager>();
        if (selectedMainCharecter == "boy")
        {
            placeObject = m_scene1BoyPrefab;

        }
        else if (selectedMainCharecter == "girl")
        {
            placeObject = m_scene1GirlPrefab;

        }
        else if (selectedMainCharecter == "cat")
        {
            placeObject = m_scene1CatPrefab;

        }
        /*Destroy(spawnedObject);
        spawnedObject = Instantiate(placeObject, placedPosition, placedRotation);

        UnityMessageManager.Instance.SendMessageToFlutter("ConnectionOK : selectedMainCharecter == " + selectedMainCharecter);*/
    }

}
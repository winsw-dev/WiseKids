using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;

public class UIManager : MonoBehaviour
{
    float deltaTime = 0.0f; // FPS log info


    public GameObject placementIndicator;

    public static Pose placementPose;
    private bool placementPoseIsValid = false;
    private ARRaycastManager raycastManager;



    [SerializeField]
    [Tooltip("The ARCameraManager which will produce frame events.")]
    ARCameraManager m_CameraManager;

    /// <summary>
    /// Get or set the <c>ARCameraManager</c>.
    /// </summary>
    public ARCameraManager cameraManager
    {
        get { return m_CameraManager; }
        set
        {
            if (m_CameraManager == value)
                return;

            if (m_CameraManager != null)
                m_CameraManager.frameReceived -= FrameChanged;

            m_CameraManager = value;

            if (m_CameraManager != null & enabled)
                m_CameraManager.frameReceived += FrameChanged;
        }
    }

    const string k_FadeOffAnim = "FadeOff";
    const string k_FadeOnAnim = "FadeOn";

    [SerializeField]
    ARPlaneManager m_PlaneManager;

    public ARPlaneManager planeManager
    {
        get { return m_PlaneManager; }
        set { m_PlaneManager = value; }
    }

    [SerializeField]
    ARRaycastManager m_RaycastManager;

    public ARRaycastManager rayCastManager
    {
        get { return m_RaycastManager; }
        set { m_RaycastManager = value; }
    }

    [SerializeField]
    Animator m_MoveDeviceAnimation;

    public Animator moveDeviceAnimation
    {
        get { return m_MoveDeviceAnimation; }
        set { m_MoveDeviceAnimation = value; }
    }

    [SerializeField]
    Animator m_TapToPlaceAnimation;

    public Animator tapToPlaceAnimation
    {
        get { return m_TapToPlaceAnimation; }
        set { m_TapToPlaceAnimation = value; }
    }

    static List<ARPlane> s_Planes = new List<ARPlane>();

    bool m_ShowingTapToPlace = false;
    bool m_ShowingMoveDevice = true;

    public static bool resetArGuildAnim = false;


    void Start()
    {

        raycastManager = FindObjectOfType<ARRaycastManager>();
        /// disable placementIndicator for automatic ar placement
        placementIndicator.SetActive(false);
    }

    void Update()
    {
        deltaTime += (Time.unscaledDeltaTime - deltaTime) * 0.1f; // FPS log info
        ///// Manually tab to place ar content (if uncomment mean use PlacementIndicator)         
        //UpdatePlacementIndicator();

        UpdatePlacementPose();
        /// disable placementIndicator for automatic ar placement
        placementIndicator.SetActive(false);

    }

    void OnEnable()
    {
        if (m_CameraManager != null)
            m_CameraManager.frameReceived += FrameChanged;

        PlaceMultipleObjectsOnPlane.onPlacedObject += PlacedObject;
    }

    void OnDisable()
    {
        if (m_CameraManager != null)
            m_CameraManager.frameReceived -= FrameChanged;

        PlaceMultipleObjectsOnPlane.onPlacedObject -= PlacedObject;
    }

    void FrameChanged(ARCameraFrameEventArgs args)
    {
        if (PlanesFound() && m_ShowingMoveDevice)
        {
            if (moveDeviceAnimation)
                moveDeviceAnimation.SetTrigger(k_FadeOffAnim);
            ///// Manually tab to place ar content
            /* if (tapToPlaceAnimation)
                 tapToPlaceAnimation.SetTrigger(k_FadeOnAnim);
*/
            m_ShowingTapToPlace = true;
            m_ShowingMoveDevice = false;
        }

        if (resetArGuildAnim) { ResetGuildAnimation(); }

        if (!m_ShowingMoveDevice && !m_ShowingTapToPlace && PlaceMultipleObjectsOnPlane.objectPlaced) { tapToPlaceAnimation.SetTrigger(k_FadeOffAnim); }


    }

    void ResetGuildAnimation()
    {
        //PlaceMultipleObjectsOnPlane.onPlacedObject -= PlacedObject;
        m_ShowingTapToPlace = false;
        m_ShowingMoveDevice = true;
        ///// Manually tab to place ar content
        //moveDeviceAnimation.SetTrigger(k_FadeOffAnim);
        if (moveDeviceAnimation)
            moveDeviceAnimation.SetTrigger(k_FadeOnAnim);

        if (tapToPlaceAnimation)
            tapToPlaceAnimation.SetTrigger(k_FadeOffAnim);
        resetArGuildAnim = false;


    }
    bool PlanesFound()
    {
        if (planeManager == null)
            return false;

        return planeManager.trackables.count > 0;
    }

    void PlacedObject()
    {

        if (m_ShowingTapToPlace)
        {
            //if (tapToPlaceAnimation)
            //tapToPlaceAnimation.SetTrigger(k_FadeOffAnim);
            UnityMessageManager.Instance.SendMessageToFlutter("Placed object");
            m_ShowingTapToPlace = false;
        }
    }




    /// <summary>
    /// /////////////////////////////////////////////////////////////////////////////////////
    /// </summary>
    private void UpdatePlacementPose()
    {
        var screenCenter = Camera.main.ViewportToScreenPoint(new Vector3(0.5f, 0.5f));
        //var screenCenter = new Vector2(Screen.width / 2, Screen.height / 2);

        var hits = new List<ARRaycastHit>();
        //var rayCastMgr = GetComponent<ARRaycastManager>();
        raycastManager.Raycast(screenCenter, hits, TrackableType.Planes);
        placementPoseIsValid = hits.Count > 0;
        if (placementPoseIsValid)
        {
            placementPose = hits[0].pose;

            var cameraForward = Camera.main.transform.forward;
            var cameraBearing = new Vector3(cameraForward.x, 0, cameraForward.z).normalized;
            placementPose.rotation = Quaternion.LookRotation(cameraBearing);
        }
    }


    private void UpdatePlacementIndicator()
    {

        if (placementPoseIsValid)
        {
            placementIndicator.SetActive(true);
            placementIndicator.transform.SetPositionAndRotation(placementPose.position, placementPose.rotation);
        }
        else
        {
            placementIndicator.SetActive(false);
        }

        if (m_ShowingTapToPlace == false && m_ShowingMoveDevice == false)
        {
            placementIndicator.SetActive(false);
        }
    }

    /*
    /// <summary>
    ///  FPS Log info
    /// </summary>
    void OnGUI()
    {
        int w = Screen.width, h = Screen.height;

        GUIStyle style = new GUIStyle();

        Rect rect = new Rect(0, 0, w, h * 2 / 100);
        style.alignment = TextAnchor.UpperLeft;
        style.fontSize = h * 2 / 100;
        style.normal.textColor = new Color(255.0f, 255.0f, 255.0f, 1.0f);
        float msec = deltaTime * 1000.0f;
        float fps = 1.0f / deltaTime;
        string text = string.Format("{0:0.0} ms ({1:0.} fps) Tap:{2} Move:{3} ReAnim:{4} \n PlandFound:{5} ObjPlaced:{6}", msec, fps, m_ShowingTapToPlace, m_ShowingMoveDevice, resetArGuildAnim, planeManager.trackables.count > 0, PlaceMultipleObjectsOnPlane.objectPlaced);
        GUI.Label(rect, text, style);
    }
    */
}

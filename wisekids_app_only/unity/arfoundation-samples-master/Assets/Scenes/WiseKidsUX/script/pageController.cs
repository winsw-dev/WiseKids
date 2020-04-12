using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class pageController : MonoBehaviour
{


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
    //////////////////////////////////////////////////////////////////// Scene2 Boy
    [SerializeField]
    [Tooltip("Instantiates this prefab on a plane at the touch location.")]
    GameObject m_scene2BoyPrefab;
    public GameObject scene2BoyPrefab
    {
        get { return m_scene2BoyPrefab; }
        set { m_scene2BoyPrefab = value; }
    }
    //////////////////////////////////////////////////////////////////// Scene2 Girl
    [SerializeField]
    [Tooltip("Instantiates this prefab on a plane at the touch location.")]
    GameObject m_scene2GirlPrefab;
    public GameObject scene2GirlPrefab
    {
        get { return m_scene2GirlPrefab; }
        set { m_scene2GirlPrefab = value; }
    }
    //////////////////////////////////////////////////////////////////// Scene2 Cat
    [SerializeField]
    [Tooltip("Instantiates this prefab on a plane at the touch location.")]
    GameObject m_scene2CatPrefab;
    public GameObject scene2CatPrefab
    {
        get { return m_scene2CatPrefab; }
        set { m_scene2CatPrefab = value; }
    }
    //////////////////////////////////////////////////////////////////// Scene3 Boy
    [SerializeField]
    [Tooltip("Instantiates this prefab on a plane at the touch location.")]
    GameObject m_scene3BoyPrefab;
    public GameObject scene3BoyPrefab
    {
        get { return m_scene3BoyPrefab; }
        set { m_scene3BoyPrefab = value; }
    }
    //////////////////////////////////////////////////////////////////// Scene3 Girl
    [SerializeField]
    [Tooltip("Instantiates this prefab on a plane at the touch location.")]
    GameObject m_scene3GirlPrefab;
    public GameObject scene3GirlPrefab
    {
        get { return m_scene3GirlPrefab; }
        set { m_scene3GirlPrefab = value; }
    }
    //////////////////////////////////////////////////////////////////// Scene3 Cat
    [SerializeField]
    [Tooltip("Instantiates this prefab on a plane at the touch location.")]
    GameObject m_scene3CatPrefab;
    public GameObject scene3CatPrefab
    {
        get { return m_scene3CatPrefab; }
        set { m_scene3CatPrefab = value; }
    }
    //////////////////////////////////////////////////////////////////// Scene4 Boy
    [SerializeField]
    [Tooltip("Instantiates this prefab on a plane at the touch location.")]
    GameObject m_scene4BoyPrefab;
    public GameObject scene4BoyPrefab
    {
        get { return m_scene4BoyPrefab; }
        set { m_scene4BoyPrefab = value; }
    }
    //////////////////////////////////////////////////////////////////// Scene4 Girl
    [SerializeField]
    [Tooltip("Instantiates this prefab on a plane at the touch location.")]
    GameObject m_scene4GirlPrefab;
    public GameObject scene4GirlPrefab
    {
        get { return m_scene4GirlPrefab; }
        set { m_scene4GirlPrefab = value; }
    }
    //////////////////////////////////////////////////////////////////// Scene4 Cat
    [SerializeField]
    [Tooltip("Instantiates this prefab on a plane at the touch location.")]
    GameObject m_scene4CatPrefab;
    public GameObject scene4CatPrefab
    {
        get { return m_scene4CatPrefab; }
        set { m_scene4CatPrefab = value; }
    }
    //////////////////////////////////////////////////////////////////// Scene5 Boy 
    [SerializeField]
    [Tooltip("Instantiates this prefab on a plane at the touch location.")]
    GameObject m_scene5BoyPrefab;
    public GameObject scene5BoyPrefab
    {
        get { return m_scene5BoyPrefab; }
        set { m_scene5BoyPrefab = value; }
    }
    //////////////////////////////////////////////////////////////////// Scene5 Girl
    [SerializeField]
    [Tooltip("Instantiates this prefab on a plane at the touch location.")]
    GameObject m_scene5GirlPrefab;
    public GameObject scene5GirlPrefab
    {
        get { return m_scene5GirlPrefab; }
        set { m_scene5GirlPrefab = value; }
    }
    //////////////////////////////////////////////////////////////////// Scene5 Cat
    [SerializeField]
    [Tooltip("Instantiates this prefab on a plane at the touch location.")]
    GameObject m_scene5CatPrefab;
    public GameObject scene5CatPrefab
    {
        get { return m_scene5CatPrefab; }
        set { m_scene5CatPrefab = value; }
    }
    //////////////////////////////////////////////////////////////////// Scene6 Boy 
    [SerializeField]
    [Tooltip("Instantiates this prefab on a plane at the touch location.")]
    GameObject m_scene6BoyPrefab;
    public GameObject scene6BoyPrefab
    {
        get { return m_scene6BoyPrefab; }
        set { m_scene6BoyPrefab = value; }
    }
    //////////////////////////////////////////////////////////////////// Scene6 Girl
    [SerializeField]
    [Tooltip("Instantiates this prefab on a plane at the touch location.")]
    GameObject m_scene6GirlPrefab;
    public GameObject scene6GirlPrefab
    {
        get { return m_scene6GirlPrefab; }
        set { m_scene6GirlPrefab = value; }
    }
    //////////////////////////////////////////////////////////////////// Scene6 Cat
    [SerializeField]
    [Tooltip("Instantiates this prefab on a plane at the touch location.")]
    GameObject m_scene6CatPrefab;
    public GameObject scene6CatPrefab
    {
        get { return m_scene6CatPrefab; }
        set { m_scene6CatPrefab = value; }
    }
    //////////////////////////////////////////////////////////////////// Scene7 Boy 
    [SerializeField]
    [Tooltip("Instantiates this prefab on a plane at the touch location.")]
    GameObject m_scene7BoyPrefab;
    public GameObject scene7BoyPrefab
    {
        get { return m_scene7BoyPrefab; }
        set { m_scene7BoyPrefab = value; }
    }
    //////////////////////////////////////////////////////////////////// Scene7 Girl
    [SerializeField]
    [Tooltip("Instantiates this prefab on a plane at the touch location.")]
    GameObject m_scene7GirlPrefab;
    public GameObject scene7GirlPrefab
    {
        get { return m_scene7GirlPrefab; }
        set { m_scene7GirlPrefab = value; }
    }
    //////////////////////////////////////////////////////////////////// Scene7 Cat
    [SerializeField]
    [Tooltip("Instantiates this prefab on a plane at the touch location.")]
    GameObject m_scene7CatPrefab;
    public GameObject scene7CatPrefab
    {
        get { return m_scene7CatPrefab; }
        set { m_scene7CatPrefab = value; }
    }


    public static int currentScene = 1;
    private GameObject placeObject;


   

    public void forwardScene()
    {
        if (currentScene == 1)
        {
            placeObject = m_scene2BoyPrefab;
            currentScene = 2;
        }
        else if(currentScene == 2)
        {
            placeObject = m_scene3BoyPrefab;
            currentScene = 3;
        }
        else if (currentScene == 3)
        {
            placeObject = m_scene4BoyPrefab;
            currentScene = 4;
        }
        else if (currentScene == 4)
        {
            placeObject = m_scene5BoyPrefab;
            currentScene = 5;
        }
        else if (currentScene == 5)
        {
            placeObject = m_scene6BoyPrefab;
            currentScene = 6;
        }
        else if (currentScene == 6)
        {
            placeObject = m_scene7BoyPrefab;
            currentScene = 7;
        }
        else if (currentScene == 7)
        {
            placeObject = m_scene7BoyPrefab;
            currentScene = 7;
        }

        Destroy(PlaceMultipleObjectsOnPlane.spawnedObject);
        PlaceMultipleObjectsOnPlane.spawnedObject = Instantiate(placeObject, PlaceMultipleObjectsOnPlane.placedPosition, PlaceMultipleObjectsOnPlane.placedRotation);

    }

    public void backwardScene() {
        if (currentScene == 1)
        {
            placeObject = m_scene1BoyPrefab;
            currentScene = 1;
        }
        else if (currentScene == 2)
        {
            placeObject = m_scene1BoyPrefab;
            currentScene = 1;
        }
        else if (currentScene == 3)
        {
            placeObject = m_scene2BoyPrefab;
            currentScene = 2;
        }
        else if (currentScene == 4)
        {
            placeObject = m_scene3BoyPrefab;
            currentScene = 3;
        }
        else if (currentScene == 5)
        {
            placeObject = m_scene4BoyPrefab;
            currentScene = 4;
        }
        else if (currentScene == 6)
        {
            placeObject = m_scene5BoyPrefab;
            currentScene = 5;
        }
        else if (currentScene == 7)
        {
            placeObject = m_scene6BoyPrefab;
            currentScene = 6;
        }
        Destroy(PlaceMultipleObjectsOnPlane.spawnedObject);
        PlaceMultipleObjectsOnPlane.spawnedObject = Instantiate(placeObject, PlaceMultipleObjectsOnPlane.placedPosition, PlaceMultipleObjectsOnPlane.placedRotation);
    }
}

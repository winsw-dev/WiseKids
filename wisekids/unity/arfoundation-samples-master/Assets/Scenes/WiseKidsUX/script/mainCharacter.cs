using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class mainCharacter : MonoBehaviour
{
    /// <summary>
    /// /////////////////////////////// Boy texture
    /// </summary>
    public Texture2D scene1BodyBoy;    
    public Texture2D scene1FaceBoy;
    public Texture2D scene1HandBoy;
    public Texture2D scene2Boy;
    public Texture2D scene3Boy;
    public Texture2D scene4Boy;
    /// <summary>
    /// /////////////////////////////// Girl texture
    /// </summary>
    public Texture2D scene1BodyGirl;
    public Texture2D scene1FaceGirl;
    public Texture2D scene1HandGirl;
    public Texture2D scene2Girl;
    public Texture2D scene3Girl;
    public Texture2D scene4Girl;
    /// <summary>
    /// //////////////////////////////// Cat texture
    /// </summary>
    public Texture2D scene1BodyCat;
    public Texture2D scene1FaceCat;
    public Texture2D scene1HandCat;
    public Texture2D scene2Cat;
    public Texture2D scene3Cat;
    public Texture2D scene4Cat;
    /// <summary>
    /// ///////////////////////////////// Material
    /// </summary>
    public Material scene1BodyCharacterMaterial;
    public Material scene1FaceCharacterMaterial;
    public Material scene1HandCharacterMaterial;
    public Material scene2CharacterMaterial;
    public Material scene3CharacterMaterial;
    public Material scene4CharacterMaterial;

    private void Awake()
    {
        scene1BodyCharacterMaterial.mainTexture = scene1BodyGirl;
        scene1FaceCharacterMaterial.mainTexture = scene1FaceGirl;
        scene1HandCharacterMaterial.mainTexture = scene1HandGirl;
        scene2CharacterMaterial.mainTexture = scene2Girl;
        scene3CharacterMaterial.mainTexture = scene3Girl;
        scene4CharacterMaterial.mainTexture = scene4Girl;

    }

    // Start is called before the first frame update
    void Start()
    {
        scene1BodyCharacterMaterial.mainTexture = scene1BodyGirl;
        scene1FaceCharacterMaterial.mainTexture = scene1FaceGirl;
        scene1HandCharacterMaterial.mainTexture = scene1HandGirl;
        scene2CharacterMaterial.mainTexture = scene2Girl;
        scene3CharacterMaterial.mainTexture = scene3Girl;
        scene4CharacterMaterial.mainTexture = scene4Girl;
    }

    // Update is called once per frame
    void Update()
    {

    }
}

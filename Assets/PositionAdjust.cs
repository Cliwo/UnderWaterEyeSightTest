using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PositionAdjust : MonoBehaviour {

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		float vert = Input.GetAxis("Vertical");
		gameObject.transform.Translate(Vector3.back * vert * Time.deltaTime);
	}
}

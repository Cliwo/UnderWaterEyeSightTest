using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LightAdjust : MonoBehaviour {
	public Light light;
	bool lightEnable;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		if(Input.GetKeyDown(KeyCode.E))
		{
			lightEnable = !lightEnable;
			light.enabled = lightEnable;
		}
	}
}

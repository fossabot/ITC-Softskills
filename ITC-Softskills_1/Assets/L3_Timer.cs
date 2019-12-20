﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using SmartLocalization;
using UnityEngine.UI;

public class L3_Timer : MonoBehaviour 
{
	public Text ActivityTimerTxt;
	//	public GameObject TimeUP;

	public int minutes,localTimer;

	public static bool TimeEnd = true;

	public static L3_Timer ins;
	private IEnumerator _ie;

	void Start ()
	{
		ins = this;
		TimeEnd = true;
		_ie = StartTimer ();
		StartCoroutine (_ie);
	}

	internal void SetActivityTimerText(int Value)
	{
		
        string niceTime;// = string.Format("{0:00}:{1:00}", minutes, Value);

        if (PlayerPrefs.GetString("currentLanguage") == "hi-IN")
        {
            niceTime = string.Format("{0:00}%{1:00}", minutes, Value);
            string time =
                ActivityTimerTxt.text = LanguageManager.Instance.GetTextValue("C_Timer") + " % " + niceTime;//+" Sec";
        }
        else
        {
            niceTime = string.Format("{0:00}:{1:00}", minutes, Value);
            string time =
                ActivityTimerTxt.text = LanguageManager.Instance.GetTextValue("C_Timer") + " : " + niceTime;//+" Sec";
        }
    }



	public IEnumerator StartTimer() 
	{
		while (localTimer >= 0)
		{
			SoundManager.instance.PlayTikTikSound ();
			SetActivityTimerText (localTimer);
			yield return new WaitForSeconds (1);
			localTimer--;
			if(localTimer==-1)
			{
				if (minutes > 0)
				{
					localTimer = 59;
					minutes--;
				}
				else
				{
					TimeEnd = false;
					StopCoroutine ("StartTimer");
					//	DragDropProbes.ins.TimeUP ();
//					GameManagerLevel2.instance.WrongOnFirstAttempt();
					if (GameManagerLevel3.instance.OptionCounter == 0) {
						GameManagerLevel3.instance.DisAppearHeads ();
					} else if (GameManagerLevel3.instance.OptionCounter == 1) {
						GameManagerLevel3.instance.DisAppearFace ();
					} else if (GameManagerLevel3.instance.OptionCounter == 2) {
						GameManagerLevel3.instance.DisAppearBodyJewel();
					} else {
						GameManagerLevel3.instance.FinalScoreDisplay ();
					}

				}
			}
		}
	}

}
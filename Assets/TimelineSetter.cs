using Sirenix.OdinInspector;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;
using Cinemachine;

public class TimelineSetter : MonoBehaviour
{
    public PlayableDirector director;

    public List<PlayableAsset> timelineEditingSequence;
    public int sequenceIndex = 0;

    [Button("Next In Sequence")]
    public void NextInSequence()
    {
        var target = timelineEditingSequence[sequenceIndex++];
        director.playableAsset = target;
        GenerateBindings();
    }


    void GenerateBindings()
    {
        var ballAnimator = GameObject.Find("TimelineBall").GetComponent<Animator>();
        var virtualCamera = GameObject.FindObjectOfType<CinemachineVirtualCamera>();
        var director = GameObject.FindObjectOfType<PlayableDirector>();
        var timelineAsset = (TimelineAsset)director.playableAsset;
        var cinemachineBrain = GameObject.FindObjectOfType<CinemachineBrain>();
        var tracks = timelineAsset.GetOutputTracks();

        int count = 0;

        foreach (var v in tracks)
        {
            director.ClearGenericBinding(v);
            if (v is SignalTrack)
            {
                var signalReceiver = GameObject.FindObjectOfType<SignalReceiver>();
                director.SetGenericBinding(v, signalReceiver);
            }
            else if (v is CinemachineTrack)
            {
                TimelineClip clipToEdit = null;
                foreach (var clip in v.GetClips())
                {
                    clipToEdit = clip;
                }
                var controlPlayableAsset = (clipToEdit.asset as CinemachineShot);
                var outBool = true;
                var bindedVirtualCamera = director.GetReferenceValue(controlPlayableAsset.VirtualCamera.exposedName, out outBool);
                director.SetReferenceValue(controlPlayableAsset.VirtualCamera.exposedName, virtualCamera);
                director.SetGenericBinding(v, cinemachineBrain);
            }
            else if (v is AnimationTrack)
            {
                if (count == 0)
                {
                    director.SetGenericBinding(v, virtualCamera.GetComponent<Animator>());
                }
                else if (count == 1)
                {
                    director.SetGenericBinding(v, ballAnimator);
                }
                else
                {
                    int idx = count - 2;
                    director.SetGenericBinding(v, GameObject.FindObjectsOfType<SkinnedMeshRenderer>()[idx].transform.parent.GetComponent<Animator>());
                }
                count++;
            }
        }
        director.RebuildGraph();
    }
}

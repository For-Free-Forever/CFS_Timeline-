using Sirenix.OdinInspector;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using UnityEngine;

public class AnimationPicker : MonoBehaviour
{
    [System.Serializable]
    public class AnimationCategory
    {
        public string categoryName;
        public List<AnimationClip> animationClips;
    }
    
    [ListDrawerSettings(ShowIndexLabels = true, ListElementLabelName = "@categoryName + ' ' + '(' + (animationClips.Count.ToString()) + '个' + ')' ", NumberOfItemsPerPage = 100)]
    public List<AnimationCategory> animationCategories;

    [Button("告知总数量")]
    public void DebugAnimationCount()
    {
        HashSet<AnimationClip> allClips = new HashSet<AnimationClip>();
        var taggedCount = 0;
        foreach (var v in animationCategories)
        {
            foreach(var clip in v.animationClips)
            {
                allClips.Add(clip);
            }
        }
        Regex cjkCharRegex = new Regex(@"\p{IsCJKUnifiedIdeographs}");
        foreach (var v in allClips)
        {
            taggedCount += v.name.Any(c => cjkCharRegex.IsMatch(c.ToString())) ? 1 : 0;
        }
        print("AnimationPicker中去重Clip数量：" + allClips.Count);
        print("AnimationPicker中已标记中文tag数量：" + taggedCount);
    }
}

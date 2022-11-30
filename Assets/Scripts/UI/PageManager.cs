using System.Collections.Generic;
using UnityEngine;

namespace UI
{
    public class PageManager : MonoBehaviour
    {
        public List<GameObject> pages;

        public void SetPage(int pageNum)
        {
            pages.ForEach(x => x.SetActive(false));
            pages[pageNum].SetActive(false);
        }
    }
}
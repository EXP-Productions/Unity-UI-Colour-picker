using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;

[RequireComponent(typeof(RectTransform))]
public class ColourPicker : MonoBehaviour, IDragHandler
{
    public Slider m_ValueSlider;
    RectTransform m_HueSatRect;
    public RectTransform m_HueSatCursor;

    Material m_ColourPickerMat;

    public Image m_Swatch;

    HSBColor m_HSBCol;

    private void Awake()
    {
        m_HueSatRect = GetComponent<RectTransform>();
        m_HSBCol = new HSBColor(Color.white);

        m_ColourPickerMat = GetComponent<Image>().material;

        SetCursorFromNorm(new Vector2(m_HSBCol.h, m_HSBCol.s));

        m_ValueSlider.value = m_HSBCol.b;
        m_ValueSlider.onValueChanged.AddListener((float f) => SetValue(f));
    }    

    public void OnDrag(PointerEventData data)
    {
        if (m_HueSatRect.IsInBounds(data))
        {
            Vector2 norm = m_HueSatRect.NormFromData(data);
            m_HSBCol.h = norm.x;
            m_HSBCol.s = norm.y;

            SetCursorFromNorm(norm);
        }

        UpdateSwatch();
    }

    void SetValue(float f)
    {
        m_HSBCol.b = f;
        UpdateSwatch();
        m_ColourPickerMat.SetFloat("_Value", f);
    }

    void UpdateSwatch()
    {
        m_Swatch.color = m_HSBCol.ToColor();
    }

    void SetCursorFromNorm(Vector2 norm)
    {
        Vector2 pos = norm; // m_HueSatRect.NormFromData(data);
        pos.x *= m_HueSatRect.sizeDelta.x;
        pos.y *= m_HueSatRect.sizeDelta.y;
        pos.y -= m_HueSatRect.sizeDelta.y;

        m_HueSatCursor.transform.localPosition = pos;
    }
}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public static class RectTransformExtensions
{
    public static Vector2 NormFromData(this RectTransform rect, PointerEventData data)
    {
        Vector3 pos = rect.WorldPosFromData(data);
        float normX = pos.x / rect.sizeDelta.x;
        float normY = (pos.y / rect.sizeDelta.y) + 1;

        return new Vector2(normX, normY);
    }

    public static Vector3 WorldPosFromData(this RectTransform rect, PointerEventData data)
    {
        Vector2 localCursor;

        if (!RectTransformUtility.ScreenPointToLocalPointInRectangle(rect, data.position, data.pressEventCamera, out localCursor))
            return Vector2.zero;

        localCursor.x = Mathf.Clamp(localCursor.x, 0, rect.sizeDelta.x);

        return localCursor;
    }

    public static bool IsInBounds(this RectTransform rect, PointerEventData data)
    {
        Vector2 localCursor = rect.WorldPosFromData(data);

        if (localCursor.x < 0 || localCursor.y > 0 || localCursor.x > rect.sizeDelta.x || localCursor.y < -rect.sizeDelta.y)
            return false;
        else
            return true;
    }
}

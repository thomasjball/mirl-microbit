namespace Math {
/**
     * Re-maps a number from one range to another. That is, a value of ``from low`` would get mapped to ``to low``, a value of ``from high`` to ``to high``, values in-between to values in-between, etc.
     * @param value value to map in ranges
     * @param fromLow the lower bound of the value's current range
     * @param fromHigh the upper bound of the value's current range, eg: 1023
     * @param toLow the lower bound of the value's target range
     * @param toHigh the upper bound of the value's target range, eg: 4
     * Performs clipping if the value is outside the source range before mapping it to the target range.
     */
    //% weight=10 blockGap=8
    //% blockId=math_map_clip block="mapClip %value|from low %fromLow|high %fromHigh|to low %toLow|high %toHigh"
    //% inlineInputMode=inline
    export function mapClip(value: number, fromLow: number, fromHigh: number, toLow: number, toHigh: number): number {
        // clip if outside range
        if (value < fromLow) value = fromLow;
        if (value > fromHigh) value = fromHigh; 
        return ((value - fromLow) * (toHigh - toLow)) / (fromHigh - fromLow) + toLow;
    }
}
//% color=#0fbc11 icon="" block="MIRL"
namespace MIRL {
/**
     * Re-maps a number between ranges whose endpoints may be in either order.
     * @param value value to map in ranges
     * @param in1 the first bound on the input range
     * @param in2 the second bound on the input range
     * @param out1 the output value corresponding to in1
     * @param out2 the output value corresponding to in2
     * Performs clipping if the value is outside the input range
     */
    //% weight=10 blockGap=8
    //% blockId=math_bounded_map block="boundedMap %value|from %in1:%in2 to %out1:%out2"
    //% inlineInputMode=inline
    export function boundedMap(value: number, in1: number, in2: number, out1: number, out2: number): number {
       return Math.constrain(Math.map(value, in1, in2, out1, out2), Math.min(out1, out2), Math.max(out1, out2))
    }
}
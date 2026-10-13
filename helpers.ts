namespace Math {
/**
     * Re-maps a number between ranges whose endpoints may be in either order.
     * @param value value to map in ranges
     * @param in1 the first bound on the input range
     * @param in2 the second bound on the input range
     * @param out1 the output value corresponding to in1
     * @param out2 the output value corresponding to in2
     * Performs clipping if the value is outside the input range before mapping it to the output range.
     */
    //% weight=10 blockGap=8
    //% blockId=math_bounded_map block="boundedMap %value|from %in1:%in2 to %out1:%out2"
    //% inlineInputMode=inline
    export function boundedMap(value: number, in1: number, in2: number, out1: number, out2: number): number {
        return BoundMap2(value, in1, in2, out1, out2);
    }

    function BoundMap1 (input2: number, in1: number, in2: number, out1: number, out2: number) {
        const inputMin = in1 < in2 ? in1 : in2;
        const inputMax = in1 > in2 ? in1 : in2;
        if (value < inputMin) value = inputMin;
        if (value > inputMax) value = inputMax;
        if (in1 === in2) return out1;
        return ((value - in1) * (out2 - out1)) / (in2 - in1) + out1;
    }
 
    function BoundMap2 (input2: number, in1: number, in2: number, out1: number, out2: number) {
        return Math.constrain(Math.map(input2, in1, in2, out1, out2), Math.min(out1, out2), Math.max(out1, out2))
    }
}
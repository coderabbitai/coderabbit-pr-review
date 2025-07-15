<?php

class BadDesign
{
    // No class doc comment — cleancode

    public function messyFunction($a, $b)
    {
        // No function doc comment — cleancode

        $unused = 123; // unused variable — cleancode

        // Long method with nested loops — codesize + design
        $sum = 0;
        for ($i = 0; $i < 10; $i++) {
            for ($j = 0; $j < 10; $j++) {
                $sum += $i * $j;
            }
        }

        // Excessive method complexity — design
        if ($a > 10) {
            if ($b < 5) {
                for ($k = 0; $k < 5; $k++) {
                    $sum += $k;
                }
            } else {
                while ($b > 0) {
                    $sum -= $b;
                    $b--;
                }
            }
        }

        return $sum;
    }
}

$obj = new BadDesign();
echo $obj->messyFunction(15, 3);

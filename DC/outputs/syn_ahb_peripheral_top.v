/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in topographical mode
// Version   : X-2025.06-SP5
// Date      : Thu Aug 20 14:16:44 2026
/////////////////////////////////////////////////////////////


module ahb_peripheral_top ( HCLK, HRESETn, HADDR, HWDATA, HWSTRB, HWRITE, 
        HTRANS, HRDATA, HREADY, UART_Rx, UART_Tx, SPI_MOSI, SPI_MISO, SPI_SCK, 
        SPI_CS_n, I2C_SDA, I2C_SCL );
  input [31:0] HADDR;
  input [31:0] HWDATA;
  input [3:0] HWSTRB;
  input [1:0] HTRANS;
  output [31:0] HRDATA;
  output [3:0] SPI_CS_n;
  input HCLK, HRESETn, HWRITE, UART_Rx, SPI_MISO;
  output HREADY, UART_Tx, SPI_MOSI, SPI_SCK;
  inout I2C_SDA,  I2C_SCL;
  wire   n5535, sram_readyout, uart_readyout, spi_readyout, i2c_readyout,
         AHB_SRAM_WRAPPER_valid_trans, AHB_SRAM_WRAPPER_sl_write,
         AHB_UART_WRAPPER_rx_valid_clr, AHB_UART_WRAPPER_rx_valid,
         AHB_UART_WRAPPER_tx_start, AHB_UART_WRAPPER_valid_trans,
         AHB_UART_WRAPPER_sl_write, AHB_SPI_WRAPPER_error,
         AHB_SPI_WRAPPER_done, AHB_SPI_WRAPPER_spi_start,
         AHB_SPI_WRAPPER_valid_trans, AHB_SPI_WRAPPER_sl_write,
         AHB_I2C_WRAPPER_error, AHB_I2C_WRAPPER_i2c_start,
         AHB_I2C_WRAPPER_valid_trans, AHB_I2C_WRAPPER_sl_write,
         AHB_SRAM_WRAPPER_AHB_SRAM_SUB_READ_WAIT,
         AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sel_reg,
         AHB_SRAM_WRAPPER_AHB_SRAM_SUB_trans_reg_1_,
         AHB_SRAM_WRAPPER_AHB_SRAM_SUB_write_reg,
         AHB_SRAM_WRAPPER_SRAM_CONTROLLER__0_net_,
         AHB_UART_WRAPPER_AHB_UART_SUB_READ_WAIT,
         AHB_UART_WRAPPER_AHB_UART_SUB_sel_reg,
         AHB_UART_WRAPPER_AHB_UART_SUB_trans_reg_1_,
         AHB_UART_WRAPPER_AHB_UART_SUB_write_reg,
         AHB_UART_WRAPPER_UART_REG_N109,
         AHB_UART_WRAPPER_UART_CONTROLLER_Rxclk_en,
         AHB_UART_WRAPPER_UART_CONTROLLER_Txclk_en,
         AHB_SPI_WRAPPER_AHB_SPI_SUB_READ_WAIT,
         AHB_SPI_WRAPPER_AHB_SPI_SUB_sel_reg,
         AHB_SPI_WRAPPER_AHB_SPI_SUB_trans_reg_1_,
         AHB_SPI_WRAPPER_AHB_SPI_SUB_write_reg, AHB_SPI_WRAPPER_SPI_REG_N105,
         AHB_SPI_WRAPPER_SPI_CONTROLLER_SUBSTATE,
         AHB_I2C_WRAPPER_AHB_I2C_SUB_READ_WAIT,
         AHB_I2C_WRAPPER_AHB_I2C_SUB_sel_reg,
         AHB_I2C_WRAPPER_AHB_I2C_SUB_trans_reg_1_,
         AHB_I2C_WRAPPER_AHB_I2C_SUB_write_reg, AHB_I2C_WRAPPER_I2C_REG_N105,
         AHB_I2C_WRAPPER_I2C_CONTROLLER_N310,
         AHB_I2C_WRAPPER_I2C_CONTROLLER_rw_mode,
         AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_25,
         AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_27,
         AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_30,
         AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_31,
         AHB_I2C_WRAPPER_I2C_CONTROLLER_SUBSTATE,
         AHB_I2C_WRAPPER_I2C_CONTROLLER_SCL_PULLDOWN,
         AHB_I2C_WRAPPER_I2C_CONTROLLER_SDA_PULLDOWN,
         AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N63,
         AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N37,
         AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N36,
         AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N35,
         AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N34,
         AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N33,
         AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N32,
         AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N25,
         AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N24,
         AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N23,
         AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N22,
         AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N21,
         AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N20,
         AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N19,
         AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N18,
         AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N17, n360, n362, n367,
         n497, n502, n506, n546, n1807, n1808, n1809, n1810, n1811, n1812,
         n1813, n1814, n1815, n1816, n1817, n1818, n1819, n1820, n1821, n1822,
         n1823, n1824, n1825, n1826, n1827, n1828, n1829, n1830, n1831, n1832,
         n1833, n1834, n1835, n1836, n1837, n1838, n1839, n1840, n1841, n1842,
         n1843, n1844, n1845, n1846, n1847, n1848, n1849, n1850, n1851, n1852,
         n1853, n1854, n1855, n1856, n1857, n1858, n1859, n1860, n1861, n1862,
         n1863, n1864, n1865, n1866, n1867, n1868, n1869, n1870, n1871, n1872,
         n1873, n1874, n1875, n1876, n1877, n1878, n1879, n1880, n1881, n1882,
         n1883, n1884, n1885, n1886, n1887, n1888, n1889, n1890, n1891, n1892,
         n1893, n1894, n1895, n1896, n1897, n1898, n1899, n1900, n1901, n1902,
         n1903, n1904, n1905, n1906, n1907, n1908, n1909, n1910, n1911, n1912,
         n1913, n1914, n1915, n1916, n1917, n1918, n1919, n1920, n1921, n1922,
         n1923, n1924, n1925, n1926, n1927, n1928, n1929, n1930, n1931, n1932,
         n1933, n1934, n1935, n1936, n1937, n1938, n1939, n1940, n1941, n1942,
         n1943, n1944, n1945, n1946, n1947, n1948, n1949, n1950, n1951, n1952,
         n1953, n1954, n1955, n1956, n1957, n1958, n1959, n1960, n1961, n1962,
         n1963, n1964, n1965, n1966, n1967, n1968, n1969, n1970, n1971, n1972,
         n1973, n1974, n1975, n1976, n1977, n1978, n1979, n1980, n1981, n1982,
         n1983, n1984, n1985, n1986, n1987, n1988, n1989, n1990, n1991, n1992,
         n1993, n1994, n1995, n1996, n1997, n1998, n1999, n2000, n2001, n2002,
         n2003, n2004, n2005, n2006, n2007, n2008, n2009, n2010, n2011, n2012,
         n2013, n2014, n2015, n2016, n2017, n2018, n2019, n2020, n2021, n2022,
         n2023, n2024, n2025, n2026, n2027, n2028, n2029, n2030, n2031, n2032,
         n2033, n2034, n2035, n2036, n2037, n2038, n2039, n2040, n2041, n2042,
         n2043, n2044, n2045, n2046, n2047, n2048, n2049, n2050, n2051, n2052,
         n2053, n2054, n2055, n2056, n2057, n2058, n2059, n2060, n2061, n2062,
         n2063, n2064, n2065, n2066, n2067, n2068, n2069, n2070, n2071, n2072,
         n2073, n2074, n2075, n2076, n2077, n2078, n2079, n2080, n2081, n2082,
         n2083, n2084, n2085, n2086, n2087, n2088, n2089, n2090, n2091, n2092,
         n2093, n2094, n2095, n2096, n2097, n2098, n2099, n2100, n2101, n2102,
         n2103, n2104, n2105, n2106, n2107, n2108, n2109, n2110, n2111, n2112,
         n2113, n2114, n2115, n2116, n2117, n2118, n2119, n2120, n2121, n2122,
         n2123, n2124, n2125, n2126, n2127, n2128, n2129, n2130, n2131, n2132,
         n2133, n2134, n2135, n2136, n2137, n2138, n2139, n2140, n2141, n2142,
         n2143, n2144, n2145, n2146, n2147, n2148, n2149, n2150, n2151, n2152,
         n2153, n2154, n2155, n2156, n2157, n2158, n2159, n2160, n2161, n2162,
         n2163, n2164, n2165, n2166, n2167, n2168, n2169, n2170, n2171, n2172,
         n2173, n2174, n2175, n2176, n2177, n2178, n2179, n2180, n2181, n2182,
         n2183, n2184, n2185, n2186, n2187, n2188, n2189, n2190, n2191, n2192,
         n2193, n2194, n2195, n2196, n2197, n2198, n2199, n2200, n2201, n2202,
         n2203, n2204, n2205, n2206, n2207, n2208, n2209, n2210, n2211, n2212,
         n2213, n2214, n2215, n2216, n2217, n2218, n2219, n2220, n2221, n2222,
         n2223, n2224, n2225, n2226, n2227, n2228, n2229, n2230, n2231, n2232,
         n2233, n2234, n2235, n2236, n2237, n2238, n2239, n2240, n2241, n2242,
         n2243, n2244, n2245, n2246, n2247, n2248, n2249, n2250, n2251, n2252,
         n2253, n2254, n2255, n2256, n2257, n2258, n2259, n2260, n2261, n2262,
         n2263, n2264, n2265, n2266, n2267, n2268, n2269, n2270, n2271, n2272,
         n2273, n2274, n2275, n2276, n2277, n2278, n2279, n2280, n2281, n2282,
         n2283, n2284, n2285, n2286, n2287, n2288, n2289, n2290, n2291, n2292,
         n2293, n2294, n2295, n2296, n2297, n2298, n2299, n2300, n2301, n2302,
         n2303, n2304, n2305, n2306, n2307, n2308, n2309, n2310, n2311, n2312,
         n2313, n2314, n2315, n2316, n2317, n2318, n2319, n2320, n2321, n2322,
         n2323, n2324, n2325, n2326, n2327, n2328, n2329, n2330, n2331, n2332,
         n2333, n2334, n2335, n2336, n2337, n2338, n2339, n2340, n2341, n2342,
         n2343, n2344, n2345, n2346, n2347, n2348, n2349, n2350, n2351, n2352,
         n2353, n2354, n2355, n2356, n2357, n2358, n2359, n2360, n2361, n2362,
         n2363, n2364, n2365, n2366, n2367, n2368, n2369, n2370, n2371, n2372,
         n2373, n2374, n2375, n2376, n2377, n2378, n2379, n2380, n2381, n2382,
         n2383, n2384, n2385, n2386, n2387, n2388, n2389, n2390, n2391, n2392,
         n2393, n2394, n2395, n2396, n2397, n2398, n2399, n2400, n2401, n2402,
         n2403, n2404, n2405, n2406, n2407, n2408, n2409, n2410, n2411, n2412,
         n2413, n2414, n2415, n2416, n2417, n2418, n2419, n2420, n2421, n2422,
         n2423, n2424, n2425, n2426, n2427, n2428, n2429, n2430, n2431, n2432,
         n2433, n2434, n2435, n2436, n2437, n2438, n2439, n2440, n2441, n2442,
         n2443, n2444, n2445, n2446, n2447, n2448, n2449, n2450, n2451, n2452,
         n2453, n2454, n2455, n2456, n2457, n2458, n2459, n2460, n2461, n2462,
         n2463, n2464, n2465, n2466, n2467, n2468, n2469, n2470, n2471, n2472,
         n2473, n2474, n2475, n2476, n2477, n2478, n2479, n2480, n2481, n2482,
         n2483, n2484, n2485, n2486, n2487, n2488, n2489, n2490, n2491, n2492,
         n2493, n2494, n2495, n2496, n2497, n2498, n2499, n2500, n2501, n2502,
         n2503, n2504, n2505, n2506, n2507, n2508, n2509, n2510, n2511, n2512,
         n2513, n2514, n2515, n2516, n2517, n2518, n2519, n2520, n2521, n2522,
         n2523, n2524, n2525, n2526, n2527, n2528, n2529, n2530, n2531, n2532,
         n2533, n2534, n2535, n2536, n2537, n2538, n2539, n2540, n2541, n2542,
         n2543, n2544, n2545, n2546, n2547, n2548, n2549, n2550, n2551, n2552,
         n2553, n2554, n2555, n2556, n2557, n2558, n2559, n2560, n2561, n2562,
         n2563, n2564, n2565, n2566, n2567, n2568, n2569, n2570, n2571, n2572,
         n2573, n2574, n2575, n2576, n2577, n2578, n2579, n2580, n2581, n2582,
         n2583, n2584, n2585, n2586, n2587, n2588, n2589, n2590, n2591, n2592,
         n2593, n2594, n2595, n2596, n2597, n2598, n2599, n2600, n2601, n2602,
         n2603, n2604, n2605, n2606, n2607, n2608, n2609, n2610, n2611, n2612,
         n2613, n2614, n2615, n2616, n2617, n2618, n2619, n2620, n2621, n2622,
         n2623, n2624, n2625, n2626, n2627, n2628, n2629, n2630, n2631, n2632,
         n2633, n2634, n2635, n2636, n2637, n2638, n2639, n2640, n2641, n2642,
         n2643, n2644, n2645, n2646, n2647, n2648, n2649, n2650, n2651, n2652,
         n2653, n2654, n2655, n2656, n2657, n2658, n2659, n2660, n2661, n2662,
         n2663, n2664, n2665, n2666, n2667, n2668, n2670, n2671, n2674, n2675,
         n2676, n2677, n2678, n2679, n2680, n2681, n2682, n2683, n2684, n2685,
         n2686, n2689, n2692, n2693, n2694, n2695, n2696, n2697, n2698, n2699,
         n2700, n2701, n2702, n2704, n2705, n2706, n2707, n2708, n2713, n2714,
         n2715, n2716, n2719, n2720, n2725, n2726, n2728, n2729, n2730, n2731,
         n2732, n2733, n2734, n2735, n2736, n2737, n2738, n2739, n2740, n2741,
         n2742, n2743, n2744, n2745, n2746, n2747, n2748, n2749, n2750, n2752,
         n2753, n2754, n2755, n2756, n2757, n2758, n2759, n2760, n2761, n2764,
         n2765, n2766, n2767, n2769, n2770, n2771, n2772, n2774, n2775, n2776,
         n2777, n2778, n2779, n2780, n2781, n2782, n2783, n2784, n2785, n2786,
         n2787, n2788, n2789, n2790, n2791, n2792, n2793, n2794, n2795, n2796,
         n2797, n2798, n2799, n2800, n2801, n2802, n2803, n2804, n2805, n2806,
         n2807, n2808, n2809, n2810, n2811, n2812, n2813, n2814, n2815, n2816,
         n2817, n2819, n2820, n2821, n2822, n2823, n2826, n2828, n2829, n2830,
         n2831, n2832, n2833, n2834, n2835, n2836, n2837, n2838, n2839, n2840,
         n2841, n2842, n2843, n2844, n2845, n2846, n2848, n2849, n2851, n2852,
         n2853, n2854, n2855, n2856, n2857, n2858, n2859, n2860, n2861, n2862,
         n2863, n2864, n2865, n2866, n2867, n2868, n2869, n2870, n2871, n2872,
         n2873, n2874, n2875, n2876, n2877, n2878, n2879, n2880, n2881, n2882,
         n2883, n2884, n2885, n2886, n2887, n2888, n2889, n2890, n2891, n2892,
         n2893, n2894, n2895, n2896, n2897, n2898, n2899, n2900, n2901, n2902,
         n2903, n2904, n2905, n2906, n2907, n2908, n2909, n2910, n2911, n2912,
         n2913, n2914, n2915, n2916, n2917, n2918, n2919, n2920, n2921, n2922,
         n2923, n2924, n2925, n2926, n2927, n2928, n2929, n2930, n2931, n2932,
         n2933, n2934, n2935, n2936, n2937, n2938, n2939, n2940, n2941, n2942,
         n2943, n2944, n2945, n2946, n2947, n2948, n2949, n2950, n2951, n2953,
         n2954, n2955, n2956, n2957, n2958, n2959, n2960, n2961, n2962, n2963,
         n2964, n2965, n2966, n2967, n2968, n2969, n2970, n2971, n2972, n2973,
         n2974, n2975, n2976, n2977, n2978, n2979, n2980, n2981, n2982, n2983,
         n2984, n2985, n2986, n2987, n2988, n2989, n2990, n2991, n2992, n2993,
         n2994, n2995, n2996, n2997, n2998, n2999, n3000, n3001, n3002, n3003,
         n3004, n3005, n3006, n3007, n3008, n3009, n3010, n3011, n3012, n3013,
         n3014, n3015, n3017, n3018, n3019, n3020, n3021, n3022, n3023, n3024,
         n3025, n3026, n3027, n3028, n3029, n3030, n3031, n3032, n3033, n3034,
         n3035, n3037, n3038, n3039, n3040, n3041, n3042, n3043, n3044, n3045,
         n3046, n3047, n3048, n3049, n3050, n3051, n3052, n3053, n3054, n3055,
         n3056, n3057, n3058, n3059, n3060, n3061, n3062, n3063, n3064, n3065,
         n3066, n3067, n3068, n3069, n3070, n3071, n3072, n3073, n3074, n3075,
         n3076, n3077, n3078, n3079, n3080, n3081, n3082, n3083, n3084, n3085,
         n3086, n3087, n3088, n3089, n3090, n3091, n3092, n3093, n3094, n3095,
         n3096, n3097, n3098, n3099, n3100, n3101, n3102, n3103, n3104, n3105,
         n3106, n3107, n3108, n3109, n3110, n3111, n3112, n3113, n3114, n3115,
         n3116, n3117, n3118, n3119, n3120, n3121, n3122, n3123, n3124, n3125,
         n3126, n3127, n3128, n3129, n3130, n3131, n3132, n3133, n3134, n3135,
         n3136, n3137, n3138, n3139, n3140, n3142, n3143, n3144, n3145, n3146,
         n3147, n3148, n3149, n3150, n3151, n3152, n3153, n3154, n3155, n3156,
         n3157, n3158, n3159, n3160, n3161, n3162, n3163, n3164, n3165, n3166,
         n3167, n3168, n3169, n3170, n3171, n3172, n3173, n3174, n3175, n3176,
         n3177, n3178, n3179, n3180, n3181, n3182, n3184, n3185, n3186, n3187,
         n3188, n3189, n3190, n3191, n3192, n3193, n3194, n3195, n3196, n3197,
         n3198, n3199, n3200, n3201, n3202, n3203, n3204, n3208, n3209, n3210,
         n3211, n3212, n3213, n3214, n3215, n3216, n3217, n3218, n3219, n3220,
         n3221, n3222, n3223, n3224, n3225, n3226, n3227, n3229, n3230, n3231,
         n3232, n3233, n3234, n3235, n3236, n3237, n3238, n3239, n3240, n3241,
         n3242, n3243, n3244, n3245, n3246, n3247, n3248, n3249, n3250, n3251,
         n3252, n3253, n3254, n3255, n3256, n3257, n3258, n3259, n3260, n3261,
         n3262, n3263, n3264, n3265, n3266, n3267, n3268, n3269, n3270, n3271,
         n3272, n3273, n3274, n3275, n3276, n3277, n3278, n3279, n3280, n3281,
         n3282, n3283, n3284, n3285, n3286, n3287, n3288, n3289, n3290, n3291,
         n3292, n3293, n3294, n3295, n3296, n3297, n3298, n3299, n3300, n3301,
         n3302, n3303, n3304, n3305, n3306, n3307, n3308, n3309, n3310, n3313,
         n3314, n3315, n3316, n3317, n3318, n3319, n3320, n3321, n3322, n3323,
         n3324, n3325, n3326, n3327, n3328, n3329, n3330, n3332, n3333, n3335,
         n3336, n3337, n3338, n3339, n3340, n3341, n3342, n3343, n3344, n3345,
         n3346, n3347, n3348, n3349, n3350, n3351, n3352, n3353, n3354, n3355,
         n3356, n3357, n3358, n3359, n3360, n3361, n3362, n3363, n3364, n3365,
         n3366, n3367, n3368, n3369, n3370, n3371, n3372, n3373, n3374, n3375,
         n3376, n3377, n3378, n3379, n3380, n3381, n3382, n3383, n3384, n3385,
         n3386, n3387, n3388, n3389, n3390, n3391, n3392, n3393, n3394, n3395,
         n3396, n3397, n3399, n3400, n3401, n3402, n3405, n3406, n3407, n3408,
         n3409, n3410, n3411, n3412, n3416, n3417, n3418, n3419, n3420, n3421,
         n3422, n3423, n3424, n3425, n3426, n3427, n3428, n3429, n3430, n3431,
         n3432, n3433, n3434, n3435, n3436, n3437, n3438, n3439, n3440, n3441,
         n3442, n3443, n3445, n3446, n3447, n3448, n3449, n3450, n3451, n3452,
         n3453, n3454, n3456, n3457, n3458, n3459, n3460, n3461, n3462, n3463,
         n3464, n3465, n3466, n3468, n3469, n3470, n3471, n3472, n3473, n3475,
         n3476, n3477, n3478, n3479, n3480, n3481, n3482, n3483, n3484, n3485,
         n3486, n3487, n3488, n3489, n3490, n3491, n3492, n3493, n3494, n3495,
         n3496, n3497, n3498, n3499, n3500, n3501, n3502, n3503, n3504, n3505,
         n3506, n3507, n3509, n3510, n3511, n3512, n3514, n3515, n3516, n3518,
         n3520, n3521, n3522, n3525, n3526, n3527, n3528, n3529, n3531, n3532,
         n3533, n3534, n3537, n3538, n3539, n3540, n3541, n3542, n3544, n3545,
         n3546, n3547, n3550, n3551, n3552, n3553, n3556, n3557, n3558, n3559,
         n3560, n3561, n3562, n3563, n3564, n3565, n3566, n3568, n3569, n3570,
         n3571, n3572, n3573, n3575, n3576, n3577, n3578, n3581, n3586, n3590,
         n3599, n3600, n3601, n3602, n3603, n3604, n3605, n3606, n3607, n3609,
         n3610, n3611, n3612, n3614, n3615, n3616, n3617, n3618, n3620, n3621,
         n3622, n3623, n3628, n3629, n3631, n3632, n3633, n3634, n3635, n3636,
         n3637, n3638, n3639, n3640, n3641, n3642, n3679, n3680, n3681, n3682,
         n3683, n3684, n3685, n3686, n3687, n3688, n3689, n3690, n3691, n3692,
         n3693, n3694, n3695, n3696, n3697, n3698, n3699, n3700, n3701, n3702,
         n3703, n3704, n3705, n3706, n3707, n3708, n3709, n3710, n3711, n3712,
         n3728, n3730, n3732, n3734, n3735, n3736, n3737, n3738, n3739, n3740,
         n3741, n3742, n3743, n3744, n3745, n3746, n3747, n3748, n3749, n3750,
         n3751, n3752, n3753, n3754, n3755, n3756, n3757, n3758, n3760, n3761,
         n3762, n3763, n3764, n3765, n3766, n3767, n3768, n3769, n3770, n3772,
         n3773, n3775, n3776, n3778, n3779, n3781, n3782, n3784, n3785, n3787,
         n3788, n3790, n3793, n3794, n3796, n3798, n3801, n3806, n3807, n3809,
         n3812, n3815, n3819, n3820, n3822, n3825, n3828, n3831, n3832, n3834,
         n3835, n3837, n3839, n3841, n3843, n3848, n3851, n3852, n3853, n3854,
         n3856, n3857, n3858, n3859, n3860, n3861, n3862, n3863, n3864, n3865,
         n3866, n3867, n3868, n3869, n3870, n3871, n3872, n3873, n3874, n3875,
         n3876, n3877, n3878, n3879, n3880, n3881, n3882, n3883, n3884, n3885,
         n3886, n3887, n3888, n3889, n3890, n3891, n3892, n3893, n3894, n3897,
         n3899, n3901, n3903, n3905, n3907, n3909, n3912, n3915, n3917, n3919,
         n3921, n3925, n3928, n3930, n3932, n3937, n3939, n3941, n3945, n3949,
         n3950, n3952, n3953, n3954, n3955, n3956, n3957, n3958, n3959, n3960,
         n3961, n3962, n3963, n3964, n3965, n3966, n3967, n3968, n3969, n3971,
         n3973, n3974, n3975, n3978, n3979, n3980, n3983, n3984, n3985, n3986,
         n3988, n3990, n3991, n3992, n3994, n3995, n3996, n3998, n4000, n4001,
         n4002, n4003, n4005, n4007, n4009, n4010, n4011, n4013, n4026, n4031,
         n4035, n4053, n4054, n4057, n4058, n4060, n4061, n4062, n4063, n4064,
         n4065, n4067, n4069, n4070, n4075, n4076, n4077, n4078, n4083, n4084,
         n4085, n4086, n4091, n4092, n4093, n4094, n4099, n4100, n4101, n4102,
         n4103, n4104, n4105, n4106, n4108, n4113, n4114, n4115, n4116, n4121,
         n4122, n4123, n4124, n4129, n4130, n4131, n4132, n4137, n4138, n4139,
         n4140, n4141, n4142, n4143, n4144, n4145, n4146, n4147, n4148, n4149,
         n4150, n4151, n4152, n4153, n4154, n4155, n4156, n4157, n4158, n4159,
         n4160, n4161, n4162, n4163, n4164, n4165, n4166, n4171, n4172, n4173,
         n4174, n4179, n4180, n4181, n4182, n4187, n4188, n4189, n4190, n4195,
         n4196, n4197, n4198, n4199, n4200, n4201, n4202, n4203, n4204, n4206,
         n4207, n4211, n4212, n4213, n4214, n4215, n4217, n4218, n4220, n4222,
         n4223, n4224, n4225, n4226, n4227, n4228, n4229, n4230, n4231, n4232,
         n4233, n4234, n4235, n4236, n4237, n4238, n4239, n4240, n4241, n4242,
         n4243, n4245, n4246, n4247, n4248, n4249, n4250, n4251, n4252, n4253,
         n4254, n4256, n4257, n4258, n4259, n4260, n4261, n4262, n4263, n4264,
         n4265, n4266, n4267, n4268, n4269, n4270, n4271, n4272, n4273, n4274,
         n4275, n4276, n4277, n4278, n4279, n4280, n4281, n4282, n4283, n4284,
         n4285, n4286, n4287, n4288, n4289, n4290, n4291, n4292, n4293, n4294,
         n4295, n4296, n4297, n4298, n4299, n4301, n4302, n4304, n4305, n4306,
         n4307, n4308, n4309, n4311, n4312, n4313, n4314, n4315, n4317, n4318,
         n4320, n4322, n4323, n4324, n4326, n4328, n4329, n4330, n4331, n4334,
         n4335, n4336, n4337, n4338, n4340, n4341, n4342, n4343, n4344, n4345,
         n4346, n4348, n4349, n4350, n4351, n4352, n4353, n4354, n4355, n4356,
         n4357, n4359, n4360, n4361, n4362, n4363, n4365, n4366, n4367, n4368,
         n4369, n4370, n4371, n4372, n4373, n4374, n4375, n4376, n4377, n4378,
         n4379, n4381, n4382, n4383, n4384, n4386, n4387, n4388, n4389, n4390,
         n4391, n4392, n4393, n4394, n4395, n4396, n4397, n4398, n4399, n4400,
         n4401, n4402, n4404, n4406, n4408, n4410, n4411, n4412, n4413, n4414,
         n4418, n4419, n4420, n4423, n4424, n4425, n4426, n4429, n4430, n4431,
         n4432, n4433, n4434, n4435, n4436, n4437, n4440, n4441, n4442, n4443,
         n4445, n4447, n4449, n4452, n4453, n4454, n4455, n4456, n4457, n4458,
         n4459, n4460, n4461, n4463, n4464, n4465, n4466, n4467, n4468, n4469,
         n4470, n4471, n4472, n4474, n4476, n4477, n4478, n4479, n4480, n4481,
         n4484, n4485, n4486, n4487, n4488, n4489, n4490, n4491, n4492, n4493,
         n4496, n4497, n4498, n4499, n4500, n4501, n4502, n4503, n4505, n4506,
         n4507, n4508, n4509, n4510, n4511, n4512, n4513, n4514, n4515, n4516,
         n4517, n4518, n4519, n4520, n4521, n4522, n4524, n4526, n4527, n4528,
         n4529, n4530, n4532, n4533, n4534, n4535, n4536, n4537, n4538, n4539,
         n4543, n4545, n4546, n4547, n4548, n4549, n4550, n4551, n4552, n4553,
         n4554, n4555, n4556, n4557, n4558, n4559, n4560, n4561, n4563, n4564,
         n4565, n4566, n4567, n4568, n4569, n4570, n4571, n4572, n4573, n4574,
         n4575, n4576, n4577, n4578, n4579, n4580, n4581, n4583, n4585, n4586,
         n4587, n4588, n4589, n4590, n4591, n4592, n4593, n4594, n4595, n4606,
         n4607, n4608, n4609, n4610, n4611, n4612, n4613, n4614, n4615, n4616,
         n4617, n4618, n4619, n4620, n4621, n4622, n4623, n4624, n4625, n4626,
         n4627, n4628, n4629, n4630, n4631, n4632, n4633, n4634, n4635, n4636,
         n4637, n4638, n4639, n4640, n4641, n4642, n4643, n4644, n4645, n4646,
         n4647, n4648, n4649, n4650, n4651, n4652, n4653, n4654, n4655, n4656,
         n4657, n4658, n4659, n4660, n4661, n4662, n4663, n4664, n4665, n4666,
         n4667, n4668, n4669, n4670, n4671, n4672, n4673, n4674, n4675, n4676,
         n4677, n4678, n4679, n4680, n4681, n4682, n4683, n4684, n4685, n4686,
         n4687, n4688, n4689, n4690, n4691, n4692, n4693, n4694, n4695, n4696,
         n4697, n4698, n4699, n4700, n4701, n4702, n4703, n4704, n4705, n4706,
         n4707, n4708, n4709, n4710, n4711, n4712, n4713, n4714, n4715, n4716,
         n4717, n4718, n4719, n4720, n4721, n4722, n4723, n4724, n4725, n4726,
         n4727, n4728, n4729, n4730, n4731, n4732, n4733, n4734, n4735, n4736,
         n4737, n4738, n4739, n4740, n4741, n4742, n4743, n4744, n4816, n4817,
         n4818, n4819, n4820, n4821, n4822, n4823, n4824, n4825, n4826, n4827,
         n4828, n4829, n4830, n4831, n4832, n4833, n4834, n4835, n4836, n4837,
         n4838, n4839, n4840, n4841, n4842, n4843, n4844, n4845, n4846, n4847,
         n4848, n4849, n4850, n4851, n4852, n4853, n4854, n4855, n4856, n4857,
         n4859, n4860, n4861, n4862, n4863, n4864, n4865, n4866, n4867, n4868,
         n4869, n4870, n4871, n4872, n4873, n4874, n4875, n4876, n4877, n4878,
         n4879, n4880, n4882, n4883, n4884, n4885, n4886, n4887, n4888, n4889,
         n4890, n4891, n4892, n4893, n4894, n4896, n4897, n4898, n4899, n4900,
         n4901, n4902, n4903, n4904, n4905, n4906, n4907, n4908, n4909, n4910,
         n4911, n4912, n4913, n4914, n4915, n4916, n4917, n4918, n4919, n4920,
         n4921, n4922, n4923, n4924, n4925, n4926, n4927, n4928, n4929, n4930,
         n4931, n4932, n4933, n4934, n4935, n4936, n4937, n4938, n4939, n4940,
         n4941, n4942, n4943, n4944, n4945, n4946, n4947, n4948, n4949, n4950,
         n4951, n4952, n4953, n4954, n4955, n4956, n4957, n4958, n4959, n4960,
         n4961, n4962, n4963, n4964, n4965, n4966, n4967, n4968, n4969, n4970,
         n4971, n4972, n4973, n4974, n4975, n4976, n4977, n4978, n4979, n4980,
         n4981, n4982, n4983, n4984, n4985, n4986, n4987, n4988, n4989, n4990,
         n4991, n4992, n4993, n4994, n4995, n4996, n4997, n4998, n4999, n5000,
         n5001, n5002, n5003, n5004, n5005, n5006, n5007, n5008, n5009, n5010,
         n5011, n5012, n5013, n5014, n5015, n5016, n5017, n5018, n5019, n5020,
         n5021, n5022, n5023, n5024, n5025, n5026, n5027, n5028, n5029, n5030,
         n5031, n5032, n5033, n5034, n5035, n5036, n5037, n5038, n5039, n5040,
         n5042, n5044, n5046, n5047, n5048, n5049, n5050, n5051, n5052, n5053,
         n5060, n5061, n5062, n5063, n5064, n5065, n5066, n5067, n5068, n5069,
         n5070, n5071, n5072, n5073, n5074, n5075, n5076, n5077, n5078, n5079,
         n5080, n5081, n5083, n5084, n5085, n5086, n5087, n5088, n5089, n5090,
         n5091, n5092, n5093, n5094, n5095, n5096, n5097, n5098, n5099, n5100,
         n5101, n5102, n5103, n5105, n5106, n5107, n5108, n5109, n5110, n5111,
         n5112, n5113, n5114, n5115, n5116, n5117, n5118, n5119, n5120, n5121,
         n5122, n5123, n5124, n5125, n5126, n5127, n5128, n5129, n5130, n5131,
         n5132, n5133, n5134, n5135, n5136, n5137, n5138, n5139, n5140, n5141,
         n5142, n5143, n5144, n5145, n5146, n5147, n5148, n5149, n5150, n5151,
         n5152, n5153, n5154, n5155, n5156, n5157, n5158, n5159, n5160, n5161,
         n5162, n5163, n5164, n5165, n5166, n5167, n5168, n5169, n5170, n5171,
         n5172, n5173, n5174, n5175, n5176, n5177, n5178, n5179, n5180, n5181,
         n5182, n5183, n5184, n5185, n5186, n5187, n5188, n5189, n5190, n5191,
         n5192, n5193, n5194, n5195, n5196, n5197, n5198, n5199, n5200, n5201,
         n5202, n5250, n5251, n5252, n5253, n5254, n5255, n5256, n5257, n5258,
         n5259, n5260, n5261, n5262, n5263, n5264, n5265, n5266, n5267, n5268,
         n5269, n5270, n5271, n5272, n5273, n5274, n5275, n5276, n5277, n5278,
         n5279, n5280, n5281, n5282, n5283, n5284, n5285, n5286, n5287, n5288,
         n5289, n5290, n5291, n5292, n5293, n5294, n5295, n5296, n5297, n5298,
         n5299, n5300, n5301, n5302, n5303, n5304, n5305, n5306, n5307, n5308,
         n5309, n5310, n5311, n5312, n5313, n5314, n5315, n5316, n5317, n5318,
         n5319, n5320, n5321, n5322, n5323, n5324, n5325, n5326, n5327, n5328,
         n5329, n5330, n5331, n5332, n5333, n5334, n5335, n5336, n5337, n5338,
         n5339, n5340, n5341, n5342, n5343, n5344, n5345, n5346, n5347, n5348,
         n5349, n5350, n5351, n5352, n5353, n5354, n5355, n5356, n5357, n5358,
         n5359, n5360, n5361, n5362, n5363, n5364, n5365, n5366, n5367, n5368,
         n5369, n5370, n5371, n5372, n5373, n5374, n5375, n5376, n5377, n5378,
         n5379, n5380, n5381, n5382, n5383, n5384, n5385, n5386, n5387, n5388,
         n5389, n5390, n5391, n5392, n5393, n5394, n5395, n5396, n5397, n5398,
         n5399, n5400, n5401, n5402, n5403, n5404, n5405, n5406, n5407, n5408,
         n5409, n5410, n5411, n5412, n5413, n5414, n5415, n5416, n5417, n5418,
         n5419, n5420, n5421, n5422, n5423, n5424, n5425, n5426, n5427, n5428,
         n5429, n5430, n5431, n5432, n5433, n5434, n5435, n5436, n5437, n5438,
         n5439, n5440, n5441, n5442, n5443, n5444, n5445, n5446, n5447, n5448,
         n5449, n5450, n5451, n5452, n5453, n5454, n5455, n5456, n5457, n5458,
         n5459, n5460, n5461, n5462, n5463, n5464, n5465, n5466, n5467, n5468,
         n5469, n5470, n5471, n5472, n5473, n5474, n5475, n5476, n5477, n5478,
         n5479, n5480, n5481, n5482, n5483, n5484, n5485, n5486, n5487, n5488,
         n5489, n5490, n5491, n5492, n5493, n5494, n5495, n5496, n5497, n5498,
         n5499, n5500, n5501, n5502, n5503, n5504, n5505, n5506, n5507, n5508,
         n5509, n5510, n5511, n5512, n5513, n5514, n5515, n5516, n5517, n5518,
         n5519, n5520, n5522, n5523, n5524, n5525, n5526, n5527, n5528, n5529,
         n5530, n5531, n5532, n5533, n5534;
  wire   [31:0] sram_rdata;
  wire   [31:0] uart_rdata;
  wire   [31:0] spi_rdata;
  wire   [31:0] i2c_rdata;
  wire   [3:0] AHB_SRAM_WRAPPER_sl_wstrb;
  wire   [31:0] AHB_SRAM_WRAPPER_sl_wdata;
  wire   [11:0] AHB_SRAM_WRAPPER_sl_addr;
  wire   [31:0] AHB_UART_WRAPPER_rx_data;
  wire   [2:0] AHB_UART_WRAPPER_rx_byte_size;
  wire   [2:0] AHB_UART_WRAPPER_tx_byte_size;
  wire   [31:0] AHB_UART_WRAPPER_tx_data;
  wire   [3:0] AHB_UART_WRAPPER_sl_wstrb;
  wire   [31:0] AHB_UART_WRAPPER_sl_wdata;
  wire   [3:0] AHB_UART_WRAPPER_sl_addr;
  wire   [31:0] AHB_UART_WRAPPER_sl_rdata;
  wire   [1:0] AHB_SPI_WRAPPER_slave_select;
  wire   [2:0] AHB_SPI_WRAPPER_rx_byte_size;
  wire   [2:0] AHB_SPI_WRAPPER_tx_byte_size;
  wire   [31:0] AHB_SPI_WRAPPER_tx_data;
  wire   [3:0] AHB_SPI_WRAPPER_sl_wstrb;
  wire   [31:0] AHB_SPI_WRAPPER_sl_wdata;
  wire   [3:0] AHB_SPI_WRAPPER_sl_addr;
  wire   [31:0] AHB_SPI_WRAPPER_sl_rdata;
  wire   [2:0] AHB_I2C_WRAPPER_rx_byte_size;
  wire   [2:0] AHB_I2C_WRAPPER_tx_byte_size;
  wire   [31:0] AHB_I2C_WRAPPER_rx_data;
  wire   [31:0] AHB_I2C_WRAPPER_tx_data;
  wire   [3:0] AHB_I2C_WRAPPER_sl_wstrb;
  wire   [31:0] AHB_I2C_WRAPPER_sl_wdata;
  wire   [3:0] AHB_I2C_WRAPPER_sl_addr;
  wire   [31:0] AHB_I2C_WRAPPER_sl_rdata;
  wire   [1:0] AHB_SRAM_WRAPPER_AHB_SRAM_SUB_read_wait_counter;
  wire   [3:0] AHB_SRAM_WRAPPER_AHB_SRAM_SUB_wstrb_reg;
  wire   [11:0] AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg;
  wire   [31:0] AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata;
  wire   [31:0] AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata;
  wire   [31:0] AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata;
  wire   [31:0] AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata;
  wire   [31:0] AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata;
  wire   [31:0] AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata;
  wire   [31:0] AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata;
  wire   [31:0] AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata;
  wire   [31:0] AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata;
  wire   [31:0] AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata;
  wire   [31:0] AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata;
  wire   [31:0] AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata;
  wire   [31:0] AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata;
  wire   [31:0] AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata;
  wire   [31:0] AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata;
  wire   [31:0] AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata;
  wire   [15:0] AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n;
  wire   [1:0] AHB_UART_WRAPPER_AHB_UART_SUB_read_wait_counter;
  wire   [3:0] AHB_UART_WRAPPER_AHB_UART_SUB_wstrb_reg;
  wire   [3:0] AHB_UART_WRAPPER_AHB_UART_SUB_addr_reg;
  wire   [1:0] AHB_SPI_WRAPPER_AHB_SPI_SUB_read_wait_counter;
  wire   [3:0] AHB_SPI_WRAPPER_AHB_SPI_SUB_wstrb_reg;
  wire   [3:0] AHB_SPI_WRAPPER_AHB_SPI_SUB_addr_reg;
  wire   [6:0] AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte;
  wire   [2:0] AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_size;
  wire   [1:0] AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_counter;
  wire   [7:0] AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte;
  wire   [2:0] AHB_SPI_WRAPPER_SPI_CONTROLLER_bit_counter;
  wire   [23:0] AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift;
  wire   [1:0] AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter;
  wire   [2:0] AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_size;
  wire   [6:0] AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter;
  wire   [1:0] AHB_SPI_WRAPPER_SPI_CONTROLLER_STATE;
  wire   [1:0] AHB_I2C_WRAPPER_AHB_I2C_SUB_read_wait_counter;
  wire   [3:0] AHB_I2C_WRAPPER_AHB_I2C_SUB_wstrb_reg;
  wire   [3:0] AHB_I2C_WRAPPER_AHB_I2C_SUB_addr_reg;
  wire   [7:0] AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte;
  wire   [2:0] AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_size;
  wire   [7:0] AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte;
  wire   [2:0] AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_size;
  wire   [1:0] AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_counter;
  wire   [1:0] AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_counter;
  wire   [23:0] AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift;
  wire   [2:0] AHB_I2C_WRAPPER_I2C_CONTROLLER_bit_counter;
  wire   [8:0] AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter;
  wire   [3:0] AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE;
  wire   [5:0] AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter;
  wire   [9:0] AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter;
  wire   [2:0] AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Bit_Counter;
  wire   [1:0] AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter;
  wire   [2:0] AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_STATE;
  wire   [1:0] AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Counter;
  wire   [7:0] AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame;
  wire   [2:0] AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter;
  wire   [3:0] AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter;
  wire   [2:0] AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_STATE;

  SRAM1RW256x32 AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM15 ( .I({n5048, n5049, 
        n5050, n5051, n5052, n5053, AHB_SRAM_WRAPPER_sl_wdata[25:20], n5060, 
        n5062, n5063, n5065, n5067, n5069, n5071, n5073, n5075, n5076, n5078, 
        n5080, AHB_SRAM_WRAPPER_sl_wdata[7], n5083, n5085, n5086, n5087, n5088, 
        n5089, n5090}), .O(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata), .A(
        {n5032, n5033, n5035, n5037, n5283, n5040, n5042, n5044}), .CE(HCLK), 
        .CSB(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[15]), .WEB(n5114), .OEB(
        n5047) );
  SRAM1RW256x32 AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM14 ( .I({n5048, n5049, 
        n5050, n5051, n5052, n5053, AHB_SRAM_WRAPPER_sl_wdata[25:20], n5061, 
        n5062, n5064, n5066, n5068, n5070, n5072, n5074, n5075, n5077, n5079, 
        n5081, AHB_SRAM_WRAPPER_sl_wdata[7], n5084, n5085, n5086, n5087, n5088, 
        n5089, n5090}), .O(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata), .A(
        {n5032, n5034, n5036, n5037, n5038, AHB_SRAM_WRAPPER_sl_addr[2:0]}), 
        .CE(HCLK), .CSB(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[14]), .WEB(n5114), .OEB(n5046) );
  SRAM1RW256x32 AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM13 ( .I({n5048, n5049, 
        n5050, n5051, n5052, n5053, AHB_SRAM_WRAPPER_sl_wdata[25:20], n5061, 
        n5062, n5064, n5066, n5068, n5070, n5072, n5074, n5075, n5077, n5079, 
        n5081, AHB_SRAM_WRAPPER_sl_wdata[7], n5084, n5085, n5086, n5087, n5088, 
        n5089, n5090}), .O(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata), .A(
        {n5032, n5034, n5036, n5037, n5038, AHB_SRAM_WRAPPER_sl_addr[2], n5270, 
        AHB_SRAM_WRAPPER_sl_addr[0]}), .CE(HCLK), .CSB(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[13]), .WEB(n5114), .OEB(n5046)
         );
  SRAM1RW256x32 AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM12 ( .I({n5048, n5049, 
        n5050, n5051, n5052, n5053, AHB_SRAM_WRAPPER_sl_wdata[25:20], n5060, 
        n5062, n5063, n5065, n5067, n5069, n5071, n5073, n5075, n5076, n5078, 
        n5080, AHB_SRAM_WRAPPER_sl_wdata[7], n5083, n5085, n5086, n5087, n5088, 
        n5089, n5090}), .O(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata), .A(
        {n5032, n5033, n5035, n5037, n5283, n5040, n5042, n5275}), .CE(HCLK), 
        .CSB(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[12]), .WEB(n5114), .OEB(
        n5047) );
  SRAM1RW256x32 AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM11 ( .I({n5048, n5049, 
        n5050, n5051, n5052, n5053, AHB_SRAM_WRAPPER_sl_wdata[25:20], n5061, 
        n5062, n5064, n5066, n5068, n5070, n5072, n5074, n5075, n5077, n5079, 
        n5081, AHB_SRAM_WRAPPER_sl_wdata[7], n5084, n5085, n5086, n5087, n5088, 
        n5089, n5090}), .O(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata), .A(
        {n5032, n5034, n5036, n5037, n5039, AHB_SRAM_WRAPPER_sl_addr[2:0]}), 
        .CE(HCLK), .CSB(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[11]), .WEB(n5114), .OEB(n5046) );
  SRAM1RW256x32 AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM10 ( .I({n5048, n5049, 
        n5050, n5051, n5052, n5053, AHB_SRAM_WRAPPER_sl_wdata[25:20], n5061, 
        n5062, n5064, n5066, n5068, n5070, n5072, n5074, n5075, n5077, n5079, 
        n5081, AHB_SRAM_WRAPPER_sl_wdata[7], n5084, n5085, n5086, n5087, n5088, 
        n5089, n5090}), .O(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata), .A(
        {n5032, n5034, n5036, n5037, n5039, AHB_SRAM_WRAPPER_sl_addr[2:0]}), 
        .CE(HCLK), .CSB(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[10]), .WEB(n5114), .OEB(n5046) );
  SRAM1RW256x32 AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM9 ( .I({n5048, n5049, 
        n5050, n5051, n5052, n5053, AHB_SRAM_WRAPPER_sl_wdata[25:20], n5061, 
        n5062, n5064, n5066, n5068, n5070, n5072, n5074, n5075, n5077, n5079, 
        n5081, AHB_SRAM_WRAPPER_sl_wdata[7], n5084, n5085, n5086, n5087, n5088, 
        n5089, n5090}), .O(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata), .A({
        n5032, n5034, n5036, n5037, n5039, AHB_SRAM_WRAPPER_sl_addr[2:0]}), 
        .CE(HCLK), .CSB(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[9]), .WEB(n5114), 
        .OEB(n5046) );
  SRAM1RW256x32 AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM8 ( .I({n5048, n5049, 
        n5050, n5051, n5052, n5053, AHB_SRAM_WRAPPER_sl_wdata[25:20], n5061, 
        n5062, n5064, n5066, n5068, n5070, n5072, n5074, n5075, n5077, n5079, 
        n5081, AHB_SRAM_WRAPPER_sl_wdata[7], n5273, n5085, n5086, n5087, n5088, 
        n5089, n5090}), .O(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata), .A({
        n5032, n5034, n5036, n5037, n5038, n5040, n5270, n5044}), .CE(HCLK), 
        .CSB(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[8]), .WEB(n5114), .OEB(
        n5046) );
  SRAM1RW256x32 AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM7 ( .I({n5048, n5049, 
        n5050, n5051, n5052, n5053, AHB_SRAM_WRAPPER_sl_wdata[25:20], n5060, 
        n5062, n5063, n5065, n5067, n5069, n5071, n5073, n5075, n5076, n5078, 
        n5080, AHB_SRAM_WRAPPER_sl_wdata[7], n5083, n5085, n5086, n5087, n5088, 
        n5089, n5090}), .O(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata), .A({
        n5032, n5033, n5035, n5037, n5283, n5040, n5042, n5275}), .CE(HCLK), 
        .CSB(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[7]), .WEB(n5114), .OEB(
        n5047) );
  SRAM1RW256x32 AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM6 ( .I({n5048, n5049, 
        n5050, n5051, n5052, n5053, AHB_SRAM_WRAPPER_sl_wdata[25:20], n5060, 
        n5062, n5063, n5065, n5067, n5069, n5071, n5073, n5075, n5076, n5078, 
        n5080, AHB_SRAM_WRAPPER_sl_wdata[7], n5083, n5085, n5086, n5087, n5088, 
        n5089, n5090}), .O(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata), .A({
        n5032, n5033, n5035, n5037, n5283, n5040, n5042, n5275}), .CE(HCLK), 
        .CSB(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[6]), .WEB(n5114), .OEB(
        n5047) );
  SRAM1RW256x32 AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM5 ( .I({n5048, n5049, 
        n5050, n5051, n5052, n5053, AHB_SRAM_WRAPPER_sl_wdata[25:20], n5060, 
        n5062, n5063, n5065, n5067, n5069, n5071, n5073, n5075, n5076, n5078, 
        n5080, AHB_SRAM_WRAPPER_sl_wdata[7], n5083, n5085, n5086, n5087, n5088, 
        n5089, n5090}), .O(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata), .A({
        n5032, n5033, n5035, n5037, n5283, n5040, n5042, n5275}), .CE(HCLK), 
        .CSB(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[5]), .WEB(n5114), .OEB(
        n5047) );
  SRAM1RW256x32 AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM4 ( .I({n5048, n5049, 
        n5050, n5051, n5052, n5053, AHB_SRAM_WRAPPER_sl_wdata[25:20], n5060, 
        n5062, n5063, n5065, n5067, n5069, n5071, n5073, n5075, n5076, n5078, 
        n5080, AHB_SRAM_WRAPPER_sl_wdata[7], n5083, n5085, n5086, n5087, n5088, 
        n5089, n5090}), .O(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata), .A({
        n5032, n5033, n5035, n5037, n5283, n5040, n5042, n5275}), .CE(HCLK), 
        .CSB(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[4]), .WEB(n5114), .OEB(
        n5047) );
  SRAM1RW256x32 AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM3 ( .I({n5048, n5049, 
        n5050, n5051, n5052, n5053, AHB_SRAM_WRAPPER_sl_wdata[25:20], n5061, 
        n5062, n5064, n5066, n5068, n5070, n5072, n5074, n5075, n5077, n5079, 
        n5081, AHB_SRAM_WRAPPER_sl_wdata[7], n5273, n5085, n5086, n5087, n5088, 
        n5089, n5090}), .O(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata), .A({
        n5032, n5034, n5036, n5037, n5283, AHB_SRAM_WRAPPER_sl_addr[2], n5270, 
        AHB_SRAM_WRAPPER_sl_addr[0]}), .CE(HCLK), .CSB(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[3]), .WEB(n5114), .OEB(n5046) );
  SRAM1RW256x32 AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM2 ( .I({n5048, n5049, 
        n5050, n5051, n5052, n5053, AHB_SRAM_WRAPPER_sl_wdata[25:20], n5061, 
        n5062, n5064, n5066, n5068, n5070, n5072, n5074, n5075, n5077, n5079, 
        n5081, AHB_SRAM_WRAPPER_sl_wdata[7], n5084, n5085, n5086, n5087, n5088, 
        n5089, n5090}), .O(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata), .A({
        n5032, n5034, n5036, n5037, n5038, AHB_SRAM_WRAPPER_sl_addr[2:0]}), 
        .CE(HCLK), .CSB(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[2]), .WEB(n5114), 
        .OEB(n5046) );
  SRAM1RW256x32 AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM1 ( .I({n5048, n5049, 
        n5050, n5051, n5052, n5053, AHB_SRAM_WRAPPER_sl_wdata[25:20], n5061, 
        n5062, n5064, n5066, n5068, n5070, n5072, n5074, n5075, n5077, n5079, 
        n5081, AHB_SRAM_WRAPPER_sl_wdata[7], n5273, n5085, n5086, n5087, n5088, 
        n5089, n5090}), .O(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata), .A({
        n5032, n5034, n5036, n5037, n5038, AHB_SRAM_WRAPPER_sl_addr[2], n5270, 
        AHB_SRAM_WRAPPER_sl_addr[0]}), .CE(HCLK), .CSB(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[1]), .WEB(n5114), .OEB(n5046) );
  SRAM1RW256x32 AHB_SRAM_WRAPPER_SRAM_CONTROLLER_SRAM0 ( .I({n5048, n5049, 
        n5050, n5051, n5052, n5053, AHB_SRAM_WRAPPER_sl_wdata[25:20], n5060, 
        n5062, n5063, n5065, n5067, n5069, n5071, n5073, n5075, n5076, n5078, 
        n5080, AHB_SRAM_WRAPPER_sl_wdata[7], n5083, n5085, n5086, n5087, n5088, 
        n5089, n5090}), .O(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata), .A({
        n5032, n5033, n5035, n5037, n5283, n5040, n5042, n5275}), .CE(HCLK), 
        .CSB(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[0]), .WEB(n5114), .OEB(
        n5047) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_READ_WAIT_reg ( .D(n2453), .CLK(
        HCLK), .RSTB(n4898), .Q(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_READ_WAIT), .QN(
        n4662) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_read_wait_counter_reg_1_ ( .D(
        n2452), .CLK(HCLK), .RSTB(n4892), .Q(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_read_wait_counter[1]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_read_wait_counter_reg_0_ ( .D(
        n2451), .CLK(HCLK), .RSTB(n4882), .Q(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_read_wait_counter[0]), .QN(n4661) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_0_ ( .D(n2450), .CLK(
        HCLK), .RSTB(n4914), .Q(sram_rdata[0]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_1_ ( .D(n2449), .CLK(
        HCLK), .RSTB(n4902), .Q(sram_rdata[1]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_2_ ( .D(n2448), .CLK(
        HCLK), .RSTB(n4902), .Q(sram_rdata[2]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_3_ ( .D(n2447), .CLK(
        HCLK), .RSTB(n4902), .Q(sram_rdata[3]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_4_ ( .D(n2446), .CLK(
        HCLK), .RSTB(n4914), .Q(sram_rdata[4]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_5_ ( .D(n2445), .CLK(
        HCLK), .RSTB(n4910), .Q(sram_rdata[5]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_6_ ( .D(n2444), .CLK(
        HCLK), .RSTB(n4902), .Q(sram_rdata[6]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_7_ ( .D(n2443), .CLK(
        HCLK), .RSTB(n4910), .Q(sram_rdata[7]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_8_ ( .D(n2442), .CLK(
        HCLK), .RSTB(n4910), .Q(sram_rdata[8]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_9_ ( .D(n2441), .CLK(
        HCLK), .RSTB(n4910), .Q(sram_rdata[9]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_10_ ( .D(n2440), .CLK(
        HCLK), .RSTB(n4910), .Q(sram_rdata[10]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_11_ ( .D(n2439), .CLK(
        HCLK), .RSTB(n4902), .Q(sram_rdata[11]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_12_ ( .D(n2438), .CLK(
        HCLK), .RSTB(n4910), .Q(sram_rdata[12]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_13_ ( .D(n2437), .CLK(
        HCLK), .RSTB(n4914), .Q(sram_rdata[13]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_14_ ( .D(n2436), .CLK(
        HCLK), .RSTB(n4914), .Q(sram_rdata[14]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_15_ ( .D(n2435), .CLK(
        HCLK), .RSTB(n4914), .Q(sram_rdata[15]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_16_ ( .D(n2434), .CLK(
        HCLK), .RSTB(n4905), .Q(sram_rdata[16]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_17_ ( .D(n2433), .CLK(
        HCLK), .RSTB(n4885), .Q(sram_rdata[17]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_18_ ( .D(n2432), .CLK(
        HCLK), .RSTB(n4885), .Q(sram_rdata[18]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_19_ ( .D(n2431), .CLK(
        HCLK), .RSTB(n4914), .Q(sram_rdata[19]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_20_ ( .D(n2430), .CLK(
        HCLK), .RSTB(n4885), .Q(sram_rdata[20]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_21_ ( .D(n2429), .CLK(
        HCLK), .RSTB(n4905), .Q(sram_rdata[21]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_22_ ( .D(n2428), .CLK(
        HCLK), .RSTB(n4885), .Q(sram_rdata[22]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_23_ ( .D(n2427), .CLK(
        HCLK), .RSTB(n4885), .Q(sram_rdata[23]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_24_ ( .D(n2426), .CLK(
        HCLK), .RSTB(n4885), .Q(sram_rdata[24]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_25_ ( .D(n2425), .CLK(
        HCLK), .RSTB(n4885), .Q(sram_rdata[25]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_26_ ( .D(n2424), .CLK(
        HCLK), .RSTB(n4885), .Q(sram_rdata[26]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_27_ ( .D(n2423), .CLK(
        HCLK), .RSTB(n4892), .Q(sram_rdata[27]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_28_ ( .D(n2422), .CLK(
        HCLK), .RSTB(n4892), .Q(sram_rdata[28]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_29_ ( .D(n2421), .CLK(
        HCLK), .RSTB(n4892), .Q(sram_rdata[29]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_30_ ( .D(n2420), .CLK(
        HCLK), .RSTB(n4892), .Q(sram_rdata[30]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HRDATA_reg_31_ ( .D(n2419), .CLK(
        HCLK), .RSTB(n4892), .Q(sram_rdata[31]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg_reg_0_ ( .D(n2418), .CLK(
        HCLK), .RSTB(n4911), .Q(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[0]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg_reg_4_ ( .D(n2414), .CLK(
        HCLK), .RSTB(n4883), .Q(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[4]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg_reg_5_ ( .D(n2413), .CLK(
        HCLK), .RSTB(n4883), .Q(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[5]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg_reg_6_ ( .D(n2412), .CLK(
        HCLK), .RSTB(n4883), .Q(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[6]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_6_ ( .D(n2400), .CLK(
        HCLK), .RSTB(n4886), .Q(AHB_SRAM_WRAPPER_sl_wdata[6]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_8_ ( .D(n2398), .CLK(
        HCLK), .RSTB(n4891), .Q(AHB_SRAM_WRAPPER_sl_wdata[8]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_9_ ( .D(n2397), .CLK(
        HCLK), .RSTB(n4891), .Q(AHB_SRAM_WRAPPER_sl_wdata[9]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_10_ ( .D(n2396), 
        .CLK(HCLK), .RSTB(n4891), .Q(AHB_SRAM_WRAPPER_sl_wdata[10]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_12_ ( .D(n2394), 
        .CLK(HCLK), .RSTB(n4909), .Q(AHB_SRAM_WRAPPER_sl_wdata[12]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_13_ ( .D(n2393), 
        .CLK(HCLK), .RSTB(n4891), .Q(AHB_SRAM_WRAPPER_sl_wdata[13]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_14_ ( .D(n2392), 
        .CLK(HCLK), .RSTB(n4909), .Q(AHB_SRAM_WRAPPER_sl_wdata[14]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_15_ ( .D(n2391), 
        .CLK(HCLK), .RSTB(n4891), .Q(AHB_SRAM_WRAPPER_sl_wdata[15]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_16_ ( .D(n2390), 
        .CLK(HCLK), .RSTB(n4909), .Q(AHB_SRAM_WRAPPER_sl_wdata[16]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_19_ ( .D(n2387), 
        .CLK(HCLK), .RSTB(n4904), .Q(AHB_SRAM_WRAPPER_sl_wdata[19]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wstrb_reg_0_ ( .D(n2373), .CLK(
        HCLK), .RSTB(n4896), .Q(AHB_SRAM_WRAPPER_sl_wstrb[0]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_wstrb_reg_reg_1_ ( .D(n2372), 
        .CLK(HCLK), .RSTB(n4898), .Q(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_wstrb_reg[1]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wstrb_reg_1_ ( .D(n2371), .CLK(
        HCLK), .RSTB(n4896), .Q(AHB_SRAM_WRAPPER_sl_wstrb[1]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_wstrb_reg_reg_2_ ( .D(n2370), 
        .CLK(HCLK), .RSTB(n4898), .Q(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_wstrb_reg[2]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wstrb_reg_2_ ( .D(n2369), .CLK(
        HCLK), .RSTB(n4908), .Q(AHB_SRAM_WRAPPER_sl_wstrb[2]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_wstrb_reg_reg_3_ ( .D(n2368), 
        .CLK(HCLK), .RSTB(n4898), .Q(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_wstrb_reg[3]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wstrb_reg_3_ ( .D(n2367), .CLK(
        HCLK), .RSTB(n4908), .Q(AHB_SRAM_WRAPPER_sl_wstrb[3]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_trans_reg_reg_1_ ( .D(n2366), 
        .CLK(HCLK), .RSTB(n4908), .Q(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_trans_reg_1_) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_valid_trans_reg ( .D(n2364), .CLK(
        HCLK), .RSTB(n4894), .Q(AHB_SRAM_WRAPPER_valid_trans) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_write_reg_reg ( .D(n2363), .CLK(
        HCLK), .RSTB(n4882), .Q(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_write_reg) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_write_reg ( .D(n2362), .CLK(
        HCLK), .RSTB(n4894), .Q(AHB_SRAM_WRAPPER_sl_write) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_addr_reg_3_ ( .D(n2358), .CLK(
        HCLK), .RSTB(n4896), .Q(AHB_SRAM_WRAPPER_sl_addr[3]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_addr_reg_4_ ( .D(n2357), .CLK(
        HCLK), .RSTB(n4883), .Q(AHB_SRAM_WRAPPER_sl_addr[4]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_addr_reg_5_ ( .D(n2356), .CLK(
        HCLK), .RSTB(n4883), .Q(AHB_SRAM_WRAPPER_sl_addr[5]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_addr_reg_6_ ( .D(n2355), .CLK(
        HCLK), .RSTB(n4883), .Q(AHB_SRAM_WRAPPER_sl_addr[6]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_addr_reg_7_ ( .D(n2354), .CLK(
        HCLK), .RSTB(n4896), .Q(AHB_SRAM_WRAPPER_sl_addr[7]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_addr_reg_8_ ( .D(n2353), .CLK(
        HCLK), .RSTB(n4896), .Q(AHB_SRAM_WRAPPER_sl_addr[8]), .QN(n4613) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_addr_reg_10_ ( .D(n2351), .CLK(
        HCLK), .RSTB(n4896), .Q(AHB_SRAM_WRAPPER_sl_addr[10]), .QN(n4611) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_READ_WAIT_reg ( .D(n2349), .CLK(
        HCLK), .RSTB(n4882), .Q(AHB_UART_WRAPPER_AHB_UART_SUB_READ_WAIT), .QN(
        n4663) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_read_wait_counter_reg_0_ ( .D(
        n2348), .CLK(HCLK), .RSTB(n4882), .Q(
        AHB_UART_WRAPPER_AHB_UART_SUB_read_wait_counter[0]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_read_wait_counter_reg_1_ ( .D(
        n2347), .CLK(HCLK), .RSTB(n4882), .Q(
        AHB_UART_WRAPPER_AHB_UART_SUB_read_wait_counter[1]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_7_ ( .D(n2335), .CLK(
        HCLK), .RSTB(n4891), .Q(AHB_UART_WRAPPER_sl_wdata[7]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_8_ ( .D(n2334), .CLK(
        HCLK), .RSTB(n4899), .Q(AHB_UART_WRAPPER_sl_wdata[8]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_9_ ( .D(n2333), .CLK(
        HCLK), .RSTB(n4891), .Q(AHB_UART_WRAPPER_sl_wdata[9]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_10_ ( .D(n2332), 
        .CLK(HCLK), .RSTB(n4891), .Q(AHB_UART_WRAPPER_sl_wdata[10]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_15_ ( .D(n2327), 
        .CLK(HCLK), .RSTB(n4891), .Q(AHB_UART_WRAPPER_sl_wdata[15]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_17_ ( .D(n2325), 
        .CLK(HCLK), .RSTB(n4909), .Q(AHB_UART_WRAPPER_sl_wdata[17]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_wstrb_reg_reg_0_ ( .D(n2310), 
        .CLK(HCLK), .RSTB(n4898), .Q(
        AHB_UART_WRAPPER_AHB_UART_SUB_wstrb_reg[0]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wstrb_reg_0_ ( .D(n2309), .CLK(
        HCLK), .RSTB(n4908), .Q(AHB_UART_WRAPPER_sl_wstrb[0]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_wstrb_reg_reg_1_ ( .D(n2308), 
        .CLK(HCLK), .RSTB(n4898), .Q(
        AHB_UART_WRAPPER_AHB_UART_SUB_wstrb_reg[1]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wstrb_reg_1_ ( .D(n2307), .CLK(
        HCLK), .RSTB(n4908), .Q(AHB_UART_WRAPPER_sl_wstrb[1]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_wstrb_reg_reg_2_ ( .D(n2306), 
        .CLK(HCLK), .RSTB(n4898), .Q(
        AHB_UART_WRAPPER_AHB_UART_SUB_wstrb_reg[2]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wstrb_reg_2_ ( .D(n2305), .CLK(
        HCLK), .RSTB(n4882), .Q(AHB_UART_WRAPPER_sl_wstrb[2]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_wstrb_reg_reg_3_ ( .D(n2304), 
        .CLK(HCLK), .RSTB(n4898), .Q(
        AHB_UART_WRAPPER_AHB_UART_SUB_wstrb_reg[3]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wstrb_reg_3_ ( .D(n2303), .CLK(
        HCLK), .RSTB(n4882), .Q(AHB_UART_WRAPPER_sl_wstrb[3]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_trans_reg_reg_1_ ( .D(n2302), 
        .CLK(HCLK), .RSTB(n4882), .Q(
        AHB_UART_WRAPPER_AHB_UART_SUB_trans_reg_1_) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sel_reg_reg ( .D(n2301), .CLK(HCLK), .RSTB(n4892), .Q(AHB_UART_WRAPPER_AHB_UART_SUB_sel_reg) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_valid_trans_reg ( .D(n2300), .CLK(
        HCLK), .RSTB(n4882), .Q(AHB_UART_WRAPPER_valid_trans) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_write_reg_reg ( .D(n2299), .CLK(
        HCLK), .RSTB(n4882), .Q(AHB_UART_WRAPPER_AHB_UART_SUB_write_reg) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_write_reg ( .D(n2298), .CLK(
        HCLK), .RSTB(n4882), .Q(AHB_UART_WRAPPER_sl_write), .QN(n4606) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_addr_reg_0_ ( .D(n2297), .CLK(
        HCLK), .RSTB(n4882), .Q(AHB_UART_WRAPPER_sl_addr[0]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_addr_reg_1_ ( .D(n2296), .CLK(
        HCLK), .RSTB(n4898), .Q(AHB_UART_WRAPPER_sl_addr[1]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_addr_reg_2_ ( .D(n2295), .CLK(
        HCLK), .RSTB(n4887), .Q(AHB_UART_WRAPPER_sl_addr[2]), .QN(n4621) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_addr_reg_3_ ( .D(n2294), .CLK(
        HCLK), .RSTB(n4887), .Q(AHB_UART_WRAPPER_sl_addr[3]), .QN(n4620) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_0_ ( .D(n2293), .CLK(
        HCLK), .RSTB(n4914), .Q(uart_rdata[0]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_1_ ( .D(n2292), .CLK(
        HCLK), .RSTB(n4902), .Q(uart_rdata[1]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_2_ ( .D(n2291), .CLK(
        HCLK), .RSTB(n4902), .Q(uart_rdata[2]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_3_ ( .D(n2290), .CLK(
        HCLK), .RSTB(n4902), .Q(uart_rdata[3]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_4_ ( .D(n2289), .CLK(
        HCLK), .RSTB(n4902), .Q(uart_rdata[4]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_5_ ( .D(n2288), .CLK(
        HCLK), .RSTB(n4902), .Q(uart_rdata[5]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_6_ ( .D(n2287), .CLK(
        HCLK), .RSTB(n4904), .Q(uart_rdata[6]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_7_ ( .D(n2286), .CLK(
        HCLK), .RSTB(n4904), .Q(uart_rdata[7]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_8_ ( .D(n2285), .CLK(
        HCLK), .RSTB(n4904), .Q(uart_rdata[8]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_9_ ( .D(n2284), .CLK(
        HCLK), .RSTB(n4904), .Q(uart_rdata[9]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_10_ ( .D(n2283), .CLK(
        HCLK), .RSTB(n4904), .Q(uart_rdata[10]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_11_ ( .D(n2282), .CLK(
        HCLK), .RSTB(n4904), .Q(uart_rdata[11]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_12_ ( .D(n2281), .CLK(
        HCLK), .RSTB(n4910), .Q(uart_rdata[12]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_13_ ( .D(n2280), .CLK(
        HCLK), .RSTB(n4914), .Q(uart_rdata[13]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_14_ ( .D(n2279), .CLK(
        HCLK), .RSTB(n4914), .Q(uart_rdata[14]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_15_ ( .D(n2278), .CLK(
        HCLK), .RSTB(n4914), .Q(uart_rdata[15]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_16_ ( .D(n2277), .CLK(
        HCLK), .RSTB(n4905), .Q(uart_rdata[16]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_17_ ( .D(n2276), .CLK(
        HCLK), .RSTB(n4885), .Q(uart_rdata[17]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_18_ ( .D(n2275), .CLK(
        HCLK), .RSTB(n4914), .Q(uart_rdata[18]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_19_ ( .D(n2274), .CLK(
        HCLK), .RSTB(n4914), .Q(uart_rdata[19]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_20_ ( .D(n2273), .CLK(
        HCLK), .RSTB(n4885), .Q(uart_rdata[20]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_21_ ( .D(n2272), .CLK(
        HCLK), .RSTB(n4905), .Q(uart_rdata[21]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_22_ ( .D(n2271), .CLK(
        HCLK), .RSTB(n4885), .Q(uart_rdata[22]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_23_ ( .D(n2270), .CLK(
        HCLK), .RSTB(n4885), .Q(uart_rdata[23]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_24_ ( .D(n2269), .CLK(
        HCLK), .RSTB(n4885), .Q(uart_rdata[24]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_25_ ( .D(n2268), .CLK(
        HCLK), .RSTB(n4885), .Q(uart_rdata[25]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_26_ ( .D(n2267), .CLK(
        HCLK), .RSTB(n4885), .Q(uart_rdata[26]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_27_ ( .D(n2266), .CLK(
        HCLK), .RSTB(n4892), .Q(uart_rdata[27]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_28_ ( .D(n2265), .CLK(
        HCLK), .RSTB(n4892), .Q(uart_rdata[28]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_29_ ( .D(n2264), .CLK(
        HCLK), .RSTB(n4892), .Q(uart_rdata[29]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_30_ ( .D(n2263), .CLK(
        HCLK), .RSTB(n4892), .Q(uart_rdata[30]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HRDATA_reg_31_ ( .D(n2262), .CLK(
        HCLK), .RSTB(n4892), .Q(uart_rdata[31]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_READ_WAIT_reg ( .D(n2261), .CLK(HCLK), .RSTB(n4892), .Q(AHB_SPI_WRAPPER_AHB_SPI_SUB_READ_WAIT), .QN(n4739) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_read_wait_counter_reg_0_ ( .D(n2260), 
        .CLK(HCLK), .RSTB(n4892), .Q(
        AHB_SPI_WRAPPER_AHB_SPI_SUB_read_wait_counter[0]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_read_wait_counter_reg_1_ ( .D(n2259), 
        .CLK(HCLK), .RSTB(n4892), .Q(
        AHB_SPI_WRAPPER_AHB_SPI_SUB_read_wait_counter[1]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wstrb_reg_0_ ( .D(n2221), .CLK(
        HCLK), .RSTB(n4897), .Q(AHB_SPI_WRAPPER_sl_wstrb[0]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wstrb_reg_1_ ( .D(n2219), .CLK(
        HCLK), .RSTB(n4897), .Q(AHB_SPI_WRAPPER_sl_wstrb[1]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_wstrb_reg_reg_2_ ( .D(n2218), .CLK(
        HCLK), .RSTB(n4898), .Q(AHB_SPI_WRAPPER_AHB_SPI_SUB_wstrb_reg[2]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wstrb_reg_2_ ( .D(n2217), .CLK(
        HCLK), .RSTB(n4892), .Q(AHB_SPI_WRAPPER_sl_wstrb[2]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wstrb_reg_3_ ( .D(n2215), .CLK(
        HCLK), .RSTB(n4897), .Q(AHB_SPI_WRAPPER_sl_wstrb[3]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_trans_reg_reg_1_ ( .D(n2214), .CLK(
        HCLK), .RSTB(n4882), .Q(AHB_SPI_WRAPPER_AHB_SPI_SUB_trans_reg_1_) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sel_reg_reg ( .D(n2213), .CLK(HCLK), 
        .RSTB(n4892), .Q(AHB_SPI_WRAPPER_AHB_SPI_SUB_sel_reg) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_valid_trans_reg ( .D(n2212), .CLK(
        HCLK), .RSTB(n4897), .Q(AHB_SPI_WRAPPER_valid_trans) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_write_reg_reg ( .D(n2211), .CLK(HCLK), .RSTB(n4892), .Q(AHB_SPI_WRAPPER_AHB_SPI_SUB_write_reg) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_write_reg ( .D(n2210), .CLK(HCLK), 
        .RSTB(n4897), .Q(AHB_SPI_WRAPPER_sl_write), .QN(n4622) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_addr_reg_0_ ( .D(n2209), .CLK(
        HCLK), .RSTB(n4897), .Q(AHB_SPI_WRAPPER_sl_addr[0]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_addr_reg_1_ ( .D(n2208), .CLK(
        HCLK), .RSTB(n4897), .Q(AHB_SPI_WRAPPER_sl_addr[1]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_addr_reg_2_ ( .D(n2207), .CLK(
        HCLK), .RSTB(n4897), .Q(AHB_SPI_WRAPPER_sl_addr[2]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_addr_reg_3_ ( .D(n2206), .CLK(
        HCLK), .RSTB(n4897), .Q(AHB_SPI_WRAPPER_sl_addr[3]), .QN(n4631) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_0_ ( .D(n2205), .CLK(HCLK), .RSTB(n4914), .Q(spi_rdata[0]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_1_ ( .D(n2204), .CLK(HCLK), .RSTB(n4902), .Q(spi_rdata[1]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_2_ ( .D(n2203), .CLK(HCLK), .RSTB(n4902), .Q(spi_rdata[2]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_3_ ( .D(n2202), .CLK(HCLK), .RSTB(n4902), .Q(spi_rdata[3]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_4_ ( .D(n2201), .CLK(HCLK), .RSTB(n4910), .Q(spi_rdata[4]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_5_ ( .D(n2200), .CLK(HCLK), .RSTB(n4910), .Q(spi_rdata[5]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_6_ ( .D(n2199), .CLK(HCLK), .RSTB(n4902), .Q(spi_rdata[6]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_7_ ( .D(n2198), .CLK(HCLK), .RSTB(n4910), .Q(spi_rdata[7]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_8_ ( .D(n2197), .CLK(HCLK), .RSTB(n4910), .Q(spi_rdata[8]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_9_ ( .D(n2196), .CLK(HCLK), .RSTB(n4910), .Q(spi_rdata[9]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_10_ ( .D(n2195), .CLK(
        HCLK), .RSTB(n4904), .Q(spi_rdata[10]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_11_ ( .D(n2194), .CLK(
        HCLK), .RSTB(n4902), .Q(spi_rdata[11]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_12_ ( .D(n2193), .CLK(
        HCLK), .RSTB(n4910), .Q(spi_rdata[12]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_13_ ( .D(n2192), .CLK(
        HCLK), .RSTB(n4914), .Q(spi_rdata[13]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_14_ ( .D(n2191), .CLK(
        HCLK), .RSTB(n4914), .Q(spi_rdata[14]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_15_ ( .D(n2190), .CLK(
        HCLK), .RSTB(n4885), .Q(spi_rdata[15]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_16_ ( .D(n2189), .CLK(
        HCLK), .RSTB(n4905), .Q(spi_rdata[16]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_17_ ( .D(n2188), .CLK(
        HCLK), .RSTB(n4885), .Q(spi_rdata[17]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_18_ ( .D(n2187), .CLK(
        HCLK), .RSTB(n4914), .Q(spi_rdata[18]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_19_ ( .D(n2186), .CLK(
        HCLK), .RSTB(n4914), .Q(spi_rdata[19]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_20_ ( .D(n2185), .CLK(
        HCLK), .RSTB(n4885), .Q(spi_rdata[20]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_21_ ( .D(n2184), .CLK(
        HCLK), .RSTB(n4905), .Q(spi_rdata[21]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_22_ ( .D(n2183), .CLK(
        HCLK), .RSTB(n4885), .Q(spi_rdata[22]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_23_ ( .D(n2182), .CLK(
        HCLK), .RSTB(n4898), .Q(spi_rdata[23]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_24_ ( .D(n2181), .CLK(
        HCLK), .RSTB(n4885), .Q(spi_rdata[24]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_25_ ( .D(n2180), .CLK(
        HCLK), .RSTB(n4885), .Q(spi_rdata[25]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_26_ ( .D(n2179), .CLK(
        HCLK), .RSTB(n4885), .Q(spi_rdata[26]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_27_ ( .D(n2178), .CLK(
        HCLK), .RSTB(n4885), .Q(spi_rdata[27]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_28_ ( .D(n2177), .CLK(
        HCLK), .RSTB(n4892), .Q(spi_rdata[28]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_29_ ( .D(n2176), .CLK(
        HCLK), .RSTB(n4892), .Q(spi_rdata[29]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_30_ ( .D(n2175), .CLK(
        HCLK), .RSTB(n4892), .Q(spi_rdata[30]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HRDATA_reg_31_ ( .D(n2174), .CLK(
        HCLK), .RSTB(n4892), .Q(spi_rdata[31]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_0_ ( .D(n2173), 
        .CLK(HCLK), .RSTB(n4906), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[0]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_1_ ( .D(n2172), 
        .CLK(HCLK), .RSTB(n4906), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[1]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_2_ ( .D(n2171), 
        .CLK(HCLK), .RSTB(n4884), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[2]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_3_ ( .D(n2170), 
        .CLK(HCLK), .RSTB(n4893), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[3]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_4_ ( .D(n2169), 
        .CLK(HCLK), .RSTB(n4884), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[4]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_5_ ( .D(n2168), 
        .CLK(HCLK), .RSTB(n4893), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[5]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_6_ ( .D(n2167), 
        .CLK(HCLK), .RSTB(n4893), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[6]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_7_ ( .D(n2166), 
        .CLK(HCLK), .RSTB(n4884), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[7]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_8_ ( .D(n2165), 
        .CLK(HCLK), .RSTB(n4893), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[8]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_9_ ( .D(n2164), 
        .CLK(HCLK), .RSTB(n4893), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[9]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_10_ ( .D(n2163), 
        .CLK(HCLK), .RSTB(n4893), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[10]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_11_ ( .D(n2162), 
        .CLK(HCLK), .RSTB(n4893), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[11]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_12_ ( .D(n2161), 
        .CLK(HCLK), .RSTB(n4893), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[12]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_13_ ( .D(n2160), 
        .CLK(HCLK), .RSTB(n4893), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[13]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_14_ ( .D(n2159), 
        .CLK(HCLK), .RSTB(n4893), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[14]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_15_ ( .D(n2158), 
        .CLK(HCLK), .RSTB(n4893), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[15]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_16_ ( .D(n2157), 
        .CLK(HCLK), .RSTB(n4893), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[16]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_17_ ( .D(n2156), 
        .CLK(HCLK), .RSTB(n4893), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[17]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_18_ ( .D(n2155), 
        .CLK(HCLK), .RSTB(n4893), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[18]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_19_ ( .D(n2154), 
        .CLK(HCLK), .RSTB(n4907), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[19]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_20_ ( .D(n2153), 
        .CLK(HCLK), .RSTB(n4907), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[20]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_21_ ( .D(n2152), 
        .CLK(HCLK), .RSTB(n4893), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[21]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_22_ ( .D(n2151), 
        .CLK(HCLK), .RSTB(n4893), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[22]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift_reg_23_ ( .D(n2150), 
        .CLK(HCLK), .RSTB(n4893), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[23]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_SUBSTATE_reg ( .D(n2149), .CLK(
        HCLK), .RSTB(n4906), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_SUBSTATE), .QN(
        n4677) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_size_reg_0_ ( .D(n2148), .CLK(
        HCLK), .RSTB(n4906), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_size[0]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_size_reg_1_ ( .D(n2147), .CLK(
        HCLK), .RSTB(n4906), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_size[1]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_size_reg_2_ ( .D(n2146), .CLK(
        HCLK), .RSTB(n4884), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_size[2]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_size_reg_0_ ( .D(n2145), .CLK(
        HCLK), .RSTB(n4906), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_size[0]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_size_reg_1_ ( .D(n2144), .CLK(
        HCLK), .RSTB(n4906), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_size[1]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_size_reg_2_ ( .D(n2143), .CLK(
        HCLK), .RSTB(n4906), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_size[2]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_STATE_reg_1_ ( .D(n2141), .CLK(
        HCLK), .RSTB(n4906), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_STATE[1]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte_reg_0_ ( .D(n2138), .CLK(
        HCLK), .RSTB(n4906), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte[0]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte_reg_1_ ( .D(n2137), .CLK(
        HCLK), .RSTB(n4906), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte[1]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte_reg_2_ ( .D(n2136), .CLK(
        HCLK), .RSTB(n4906), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte[2]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte_reg_3_ ( .D(n2135), .CLK(
        HCLK), .RSTB(n4906), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte[3]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte_reg_4_ ( .D(n2134), .CLK(
        HCLK), .RSTB(n4893), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte[4]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte_reg_5_ ( .D(n2133), .CLK(
        HCLK), .RSTB(n4906), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte[5]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte_reg_6_ ( .D(n2132), .CLK(
        HCLK), .RSTB(n4906), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte[6]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_done_reg ( .D(n2131), .CLK(HCLK), 
        .RSTB(n4906), .Q(AHB_SPI_WRAPPER_done), .QN(n4623) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter_reg_0_ ( .D(n2130), 
        .CLK(HCLK), .RSTB(n4906), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[0]), .QN(n4664) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter_reg_1_ ( .D(n2129), 
        .CLK(HCLK), .RSTB(n4906), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[1]), .QN(n4665) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter_reg_2_ ( .D(n2128), 
        .CLK(HCLK), .RSTB(n4906), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[2]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter_reg_3_ ( .D(n2127), 
        .CLK(HCLK), .RSTB(n4884), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[3]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter_reg_4_ ( .D(n2126), 
        .CLK(HCLK), .RSTB(n4884), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[4]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter_reg_5_ ( .D(n2125), 
        .CLK(HCLK), .RSTB(n4884), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[5]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter_reg_6_ ( .D(n2124), 
        .CLK(HCLK), .RSTB(n4884), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[6]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte_reg_0_ ( .D(n2123), .CLK(
        HCLK), .RSTB(n4894), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte[0]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_24_ ( .D(n2122), 
        .CLK(HCLK), .RSTB(n4907), .QN(n4666) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_16_ ( .D(n2121), 
        .CLK(HCLK), .RSTB(n4907), .QN(n4668) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_8_ ( .D(n2120), .CLK(
        HCLK), .RSTB(n4907), .QN(n4670) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_25_ ( .D(n2117), 
        .CLK(HCLK), .RSTB(n4907), .QN(n4672) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_17_ ( .D(n2116), 
        .CLK(HCLK), .RSTB(n4894), .QN(n4673) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_9_ ( .D(n2115), .CLK(
        HCLK), .RSTB(n4907), .QN(n4674) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte_reg_2_ ( .D(n2113), .CLK(
        HCLK), .RSTB(n4894), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte[2]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_26_ ( .D(n2112), 
        .CLK(HCLK), .RSTB(n4907), .QN(n4678) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_18_ ( .D(n2111), 
        .CLK(HCLK), .RSTB(n4894), .QN(n4679) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_10_ ( .D(n2110), 
        .CLK(HCLK), .RSTB(n4894), .QN(n4680) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte_reg_3_ ( .D(n2108), .CLK(
        HCLK), .RSTB(n4894), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte[3]), 
        .QN(n4686) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_27_ ( .D(n2107), 
        .CLK(HCLK), .RSTB(n4907), .QN(n4682) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_19_ ( .D(n2106), 
        .CLK(HCLK), .RSTB(n4894), .QN(n4683) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_11_ ( .D(n2105), 
        .CLK(HCLK), .RSTB(n4894), .QN(n4684) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_28_ ( .D(n2102), 
        .CLK(HCLK), .RSTB(n4907), .QN(n4687) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_20_ ( .D(n2101), 
        .CLK(HCLK), .RSTB(n4894), .QN(n4688) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_12_ ( .D(n2100), 
        .CLK(HCLK), .RSTB(n4908), .QN(n4689) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_4_ ( .D(n2099), .CLK(
        HCLK), .RSTB(n4907), .QN(n4690) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte_reg_5_ ( .D(n2098), .CLK(
        HCLK), .RSTB(n4894), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte[5]), 
        .QN(n4696) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_29_ ( .D(n2097), 
        .CLK(HCLK), .RSTB(n4907), .QN(n4692) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_21_ ( .D(n2096), 
        .CLK(HCLK), .RSTB(n4894), .QN(n4693) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_13_ ( .D(n2095), 
        .CLK(HCLK), .RSTB(n4894), .QN(n4694) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte_reg_6_ ( .D(n2093), .CLK(
        HCLK), .RSTB(n4894), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte[6]), 
        .QN(n4701) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_30_ ( .D(n2092), 
        .CLK(HCLK), .RSTB(n4907), .QN(n4697) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_22_ ( .D(n2091), 
        .CLK(HCLK), .RSTB(n4894), .QN(n4698) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_14_ ( .D(n2090), 
        .CLK(HCLK), .RSTB(n4894), .QN(n4699) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte_reg_7_ ( .D(n2088), .CLK(
        HCLK), .RSTB(n4894), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte[7]), 
        .QN(n4706) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_31_ ( .D(n2087), 
        .CLK(HCLK), .RSTB(n4907), .QN(n4702) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_23_ ( .D(n2086), 
        .CLK(HCLK), .RSTB(n4908), .QN(n4703) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_15_ ( .D(n2085), 
        .CLK(HCLK), .RSTB(n4908), .QN(n4704) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_bit_counter_reg_1_ ( .D(n2080), 
        .CLK(HCLK), .RSTB(n4906), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_bit_counter[1]), .QN(n4707) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_READ_WAIT_reg ( .D(n2076), .CLK(HCLK), .RSTB(n4898), .Q(AHB_I2C_WRAPPER_AHB_I2C_SUB_READ_WAIT), .QN(n4740) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_read_wait_counter_reg_0_ ( .D(n2075), 
        .CLK(HCLK), .RSTB(n4898), .Q(
        AHB_I2C_WRAPPER_AHB_I2C_SUB_read_wait_counter[0]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_read_wait_counter_reg_1_ ( .D(n2074), 
        .CLK(HCLK), .RSTB(n4898), .Q(
        AHB_I2C_WRAPPER_AHB_I2C_SUB_read_wait_counter[1]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_addr_reg_reg_0_ ( .D(n2073), .CLK(
        HCLK), .RSTB(n4894), .Q(AHB_I2C_WRAPPER_AHB_I2C_SUB_addr_reg[0]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_0_ ( .D(n2069), .CLK(
        HCLK), .RSTB(n4889), .Q(AHB_I2C_WRAPPER_sl_wdata[0]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_7_ ( .D(n2062), .CLK(
        HCLK), .RSTB(n4891), .Q(AHB_I2C_WRAPPER_sl_wdata[7]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_8_ ( .D(n2061), .CLK(
        HCLK), .RSTB(n4899), .Q(AHB_I2C_WRAPPER_sl_wdata[8]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_9_ ( .D(n2060), .CLK(
        HCLK), .RSTB(n4891), .Q(AHB_I2C_WRAPPER_sl_wdata[9]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_10_ ( .D(n2059), .CLK(
        HCLK), .RSTB(n4891), .Q(AHB_I2C_WRAPPER_sl_wdata[10]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_11_ ( .D(n2058), .CLK(
        HCLK), .RSTB(n4891), .Q(AHB_I2C_WRAPPER_sl_wdata[11]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_12_ ( .D(n2057), .CLK(
        HCLK), .RSTB(n4909), .Q(AHB_I2C_WRAPPER_sl_wdata[12]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_13_ ( .D(n2056), .CLK(
        HCLK), .RSTB(n4891), .Q(AHB_I2C_WRAPPER_sl_wdata[13]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_14_ ( .D(n2055), .CLK(
        HCLK), .RSTB(n4909), .Q(AHB_I2C_WRAPPER_sl_wdata[14]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_15_ ( .D(n2054), .CLK(
        HCLK), .RSTB(n4891), .Q(AHB_I2C_WRAPPER_sl_wdata[15]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_16_ ( .D(n2053), .CLK(
        HCLK), .RSTB(n4886), .Q(AHB_I2C_WRAPPER_sl_wdata[16]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_17_ ( .D(n2052), .CLK(
        HCLK), .RSTB(n4909), .Q(AHB_I2C_WRAPPER_sl_wdata[17]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_18_ ( .D(n2051), .CLK(
        HCLK), .RSTB(n4891), .Q(AHB_I2C_WRAPPER_sl_wdata[18]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_22_ ( .D(n2047), .CLK(
        HCLK), .RSTB(n4904), .Q(AHB_I2C_WRAPPER_sl_wdata[22]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_23_ ( .D(n2046), .CLK(
        HCLK), .RSTB(n4904), .Q(AHB_I2C_WRAPPER_sl_wdata[23]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_24_ ( .D(n2045), .CLK(
        HCLK), .RSTB(n4904), .Q(AHB_I2C_WRAPPER_sl_wdata[24]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_26_ ( .D(n2043), .CLK(
        HCLK), .RSTB(n4889), .Q(AHB_I2C_WRAPPER_sl_wdata[26]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_28_ ( .D(n2041), .CLK(
        HCLK), .RSTB(n4888), .Q(AHB_I2C_WRAPPER_sl_wdata[28]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_29_ ( .D(n2040), .CLK(
        HCLK), .RSTB(n4888), .Q(AHB_I2C_WRAPPER_sl_wdata[29]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_30_ ( .D(n2039), .CLK(
        HCLK), .RSTB(n4888), .Q(AHB_I2C_WRAPPER_sl_wdata[30]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_31_ ( .D(n2038), .CLK(
        HCLK), .RSTB(n4888), .Q(AHB_I2C_WRAPPER_sl_wdata[31]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_wstrb_reg_reg_0_ ( .D(n2037), .CLK(
        HCLK), .RSTB(n4905), .Q(AHB_I2C_WRAPPER_AHB_I2C_SUB_wstrb_reg[0]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wstrb_reg_0_ ( .D(n2036), .CLK(
        HCLK), .RSTB(n4908), .Q(AHB_I2C_WRAPPER_sl_wstrb[0]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_wstrb_reg_reg_1_ ( .D(n2035), .CLK(
        HCLK), .RSTB(n4898), .Q(AHB_I2C_WRAPPER_AHB_I2C_SUB_wstrb_reg[1]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wstrb_reg_1_ ( .D(n2034), .CLK(
        HCLK), .RSTB(n4908), .Q(AHB_I2C_WRAPPER_sl_wstrb[1]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_wstrb_reg_reg_2_ ( .D(n2033), .CLK(
        HCLK), .RSTB(n4898), .Q(AHB_I2C_WRAPPER_AHB_I2C_SUB_wstrb_reg[2]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wstrb_reg_2_ ( .D(n2032), .CLK(
        HCLK), .RSTB(n4908), .Q(AHB_I2C_WRAPPER_sl_wstrb[2]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_wstrb_reg_reg_3_ ( .D(n2031), .CLK(
        HCLK), .RSTB(n4898), .Q(AHB_I2C_WRAPPER_AHB_I2C_SUB_wstrb_reg[3]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wstrb_reg_3_ ( .D(n2030), .CLK(
        HCLK), .RSTB(n4908), .Q(AHB_I2C_WRAPPER_sl_wstrb[3]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_trans_reg_reg_1_ ( .D(n2029), .CLK(
        HCLK), .RSTB(n4908), .Q(AHB_I2C_WRAPPER_AHB_I2C_SUB_trans_reg_1_) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sel_reg_reg ( .D(n2028), .CLK(HCLK), 
        .RSTB(n4898), .Q(AHB_I2C_WRAPPER_AHB_I2C_SUB_sel_reg) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_valid_trans_reg ( .D(n2027), .CLK(
        HCLK), .RSTB(n4908), .Q(AHB_I2C_WRAPPER_valid_trans) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_write_reg_reg ( .D(n2026), .CLK(HCLK), .RSTB(n4898), .Q(AHB_I2C_WRAPPER_AHB_I2C_SUB_write_reg) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_write_reg ( .D(n2025), .CLK(HCLK), 
        .RSTB(n4908), .Q(AHB_I2C_WRAPPER_sl_write), .QN(n4632) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_addr_reg_0_ ( .D(n2024), .CLK(
        HCLK), .RSTB(n4908), .Q(AHB_I2C_WRAPPER_sl_addr[0]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_addr_reg_1_ ( .D(n2023), .CLK(
        HCLK), .RSTB(n4908), .Q(AHB_I2C_WRAPPER_sl_addr[1]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_addr_reg_2_ ( .D(n2022), .CLK(
        HCLK), .RSTB(n4908), .Q(AHB_I2C_WRAPPER_sl_addr[2]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_addr_reg_3_ ( .D(n2021), .CLK(
        HCLK), .RSTB(n4908), .Q(AHB_I2C_WRAPPER_sl_addr[3]), .QN(n4660) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_0_ ( .D(n2020), .CLK(HCLK), .RSTB(n4914), .Q(i2c_rdata[0]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_1_ ( .D(n2019), .CLK(HCLK), .RSTB(n4902), .Q(i2c_rdata[1]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_2_ ( .D(n2018), .CLK(HCLK), .RSTB(n4902), .Q(i2c_rdata[2]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_3_ ( .D(n2017), .CLK(HCLK), .RSTB(n4902), .Q(i2c_rdata[3]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_4_ ( .D(n2016), .CLK(HCLK), .RSTB(n4902), .Q(i2c_rdata[4]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_5_ ( .D(n2015), .CLK(HCLK), .RSTB(n4902), .Q(i2c_rdata[5]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_6_ ( .D(n2014), .CLK(HCLK), .RSTB(n4902), .Q(i2c_rdata[6]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_7_ ( .D(n2013), .CLK(HCLK), .RSTB(n4904), .Q(i2c_rdata[7]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_8_ ( .D(n2012), .CLK(HCLK), .RSTB(n4904), .Q(i2c_rdata[8]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_9_ ( .D(n2011), .CLK(HCLK), .RSTB(n4904), .Q(i2c_rdata[9]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_10_ ( .D(n2010), .CLK(
        HCLK), .RSTB(n4904), .Q(i2c_rdata[10]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_11_ ( .D(n2009), .CLK(
        HCLK), .RSTB(n4904), .Q(i2c_rdata[11]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_12_ ( .D(n2008), .CLK(
        HCLK), .RSTB(n4910), .Q(i2c_rdata[12]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_13_ ( .D(n2007), .CLK(
        HCLK), .RSTB(n4910), .Q(i2c_rdata[13]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_14_ ( .D(n2006), .CLK(
        HCLK), .RSTB(n4914), .Q(i2c_rdata[14]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_15_ ( .D(n2005), .CLK(
        HCLK), .RSTB(n4885), .Q(i2c_rdata[15]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_16_ ( .D(n2004), .CLK(
        HCLK), .RSTB(n4905), .Q(i2c_rdata[16]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_17_ ( .D(n2003), .CLK(
        HCLK), .RSTB(n4885), .Q(i2c_rdata[17]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_18_ ( .D(n2002), .CLK(
        HCLK), .RSTB(n4914), .Q(i2c_rdata[18]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_19_ ( .D(n2001), .CLK(
        HCLK), .RSTB(n4914), .Q(i2c_rdata[19]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_20_ ( .D(n2000), .CLK(
        HCLK), .RSTB(n4885), .Q(i2c_rdata[20]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_21_ ( .D(n1999), .CLK(
        HCLK), .RSTB(n4905), .Q(i2c_rdata[21]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_22_ ( .D(n1998), .CLK(
        HCLK), .RSTB(n4905), .Q(i2c_rdata[22]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_23_ ( .D(n1997), .CLK(
        HCLK), .RSTB(n4898), .Q(i2c_rdata[23]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_24_ ( .D(n1996), .CLK(
        HCLK), .RSTB(n4885), .Q(i2c_rdata[24]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_25_ ( .D(n1995), .CLK(
        HCLK), .RSTB(n4885), .Q(i2c_rdata[25]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_26_ ( .D(n1994), .CLK(
        HCLK), .RSTB(n4885), .Q(i2c_rdata[26]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_27_ ( .D(n1993), .CLK(
        HCLK), .RSTB(n4892), .Q(i2c_rdata[27]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_28_ ( .D(n1992), .CLK(
        HCLK), .RSTB(n4892), .Q(i2c_rdata[28]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_29_ ( .D(n1991), .CLK(
        HCLK), .RSTB(n4892), .Q(i2c_rdata[29]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_30_ ( .D(n1990), .CLK(
        HCLK), .RSTB(n4892), .Q(i2c_rdata[30]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HRDATA_reg_31_ ( .D(n1989), .CLK(
        HCLK), .RSTB(n4892), .Q(i2c_rdata[31]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_7_ ( .D(n1981), 
        .CLK(HCLK), .RSTB(n4891), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[7]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_8_ ( .D(n1980), 
        .CLK(HCLK), .RSTB(n4899), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[8]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_9_ ( .D(n1979), 
        .CLK(HCLK), .RSTB(n4899), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[9]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_10_ ( .D(n1978), 
        .CLK(HCLK), .RSTB(n4899), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[10]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_14_ ( .D(n1974), 
        .CLK(HCLK), .RSTB(n4913), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[14]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_15_ ( .D(n1973), 
        .CLK(HCLK), .RSTB(n4891), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[15]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_16_ ( .D(n1972), 
        .CLK(HCLK), .RSTB(n4891), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[16]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_17_ ( .D(n1971), 
        .CLK(HCLK), .RSTB(n4899), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[17]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_18_ ( .D(n1970), 
        .CLK(HCLK), .RSTB(n4899), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[18]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_19_ ( .D(n1969), 
        .CLK(HCLK), .RSTB(n4899), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[19]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_20_ ( .D(n1968), 
        .CLK(HCLK), .RSTB(n4903), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[20]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_21_ ( .D(n1967), 
        .CLK(HCLK), .RSTB(n4899), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[21]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_22_ ( .D(n1966), 
        .CLK(HCLK), .RSTB(n4891), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[22]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_23_ ( .D(n1965), 
        .CLK(HCLK), .RSTB(n4891), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[23]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_25_ ( .D(n1964), 
        .CLK(HCLK), .RSTB(n4887), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_25) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_26_ ( .D(n1963), 
        .CLK(HCLK), .RSTB(n4903), .QN(n4721) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_27_ ( .D(n1962), 
        .CLK(HCLK), .RSTB(n4903), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_27) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_28_ ( .D(n1961), 
        .CLK(HCLK), .RSTB(n4903), .QN(n4722) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_29_ ( .D(n1960), 
        .CLK(HCLK), .RSTB(n4913), .QN(n4723) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_30_ ( .D(n1959), 
        .CLK(HCLK), .RSTB(n4901), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_30) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_31_ ( .D(n1958), 
        .CLK(HCLK), .RSTB(n4901), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_31) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_size_reg_2_ ( .D(n1955), .CLK(
        HCLK), .RSTB(n4905), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_size[2]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_SCL_PULLDOWN_reg ( .D(n1953), 
        .CLK(HCLK), .RSTB(n4911), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_SCL_PULLDOWN), .QN(n5513) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_bit_counter_reg_0_ ( .D(n1952), 
        .CLK(HCLK), .RSTB(n4913), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_bit_counter[0]), .QN(n4726) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_bit_counter_reg_1_ ( .D(n1951), 
        .CLK(HCLK), .RSTB(n4913), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_bit_counter[1]), .QN(n4727) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_bit_counter_reg_2_ ( .D(n1950), 
        .CLK(HCLK), .RSTB(n4913), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_bit_counter[2]), .QN(n4728) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_SDA_PULLDOWN_reg ( .D(n1949), 
        .CLK(HCLK), .RSTB(n4901), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_SDA_PULLDOWN) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter_reg_0_ ( .D(n1948), 
        .CLK(HCLK), .RSTB(n4903), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[0]), .QN(n4714) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter_reg_1_ ( .D(n1947), 
        .CLK(HCLK), .RSTB(n4903), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[1]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter_reg_2_ ( .D(n1946), 
        .CLK(HCLK), .RSTB(n4903), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[2]), .QN(n4715) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter_reg_3_ ( .D(n1945), 
        .CLK(HCLK), .RSTB(n4879), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[3]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter_reg_4_ ( .D(n1944), 
        .CLK(HCLK), .RSTB(n4903), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[4]), .QN(n4716) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter_reg_5_ ( .D(n1943), 
        .CLK(HCLK), .RSTB(n4879), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[5]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter_reg_6_ ( .D(n1942), 
        .CLK(HCLK), .RSTB(n4903), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[6]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter_reg_7_ ( .D(n1941), 
        .CLK(HCLK), .RSTB(n4903), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[7]), .QN(n4717) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter_reg_8_ ( .D(n1940), 
        .CLK(HCLK), .RSTB(n4903), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[8]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE_reg_1_ ( .D(n1934), .CLK(
        HCLK), .RSTB(n4901), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[1]), .QN(
        n4718) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_done_reg ( .D(n1931), .CLK(HCLK), 
        .RSTB(n4901), .QN(n4720) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_read_mode_start_reg ( .D(n1928), 
        .CLK(HCLK), .RSTB(n4891), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_N310) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_counter_reg_0_ ( .D(n1927), 
        .CLK(HCLK), .RSTB(n4903), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_counter[0]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_counter_reg_1_ ( .D(n1926), 
        .CLK(HCLK), .RSTB(n4903), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_counter[1]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte_reg_6_ ( .D(n1919), .CLK(
        HCLK), .RSTB(n4901), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[6]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte_reg_7_ ( .D(n1918), .CLK(
        HCLK), .RSTB(n4891), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[7]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte_reg_7_ ( .D(n1917), .CLK(
        HCLK), .RSTB(n4901), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[7]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_31_ ( .D(n1916), 
        .CLK(HCLK), .RSTB(n4901), .Q(AHB_I2C_WRAPPER_rx_data[31]), .QN(n4659)
         );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_23_ ( .D(n1915), 
        .CLK(HCLK), .RSTB(n4889), .Q(AHB_I2C_WRAPPER_rx_data[23]), .QN(n4649)
         );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_15_ ( .D(n1914), 
        .CLK(HCLK), .RSTB(n4889), .Q(AHB_I2C_WRAPPER_rx_data[15]), .QN(n4641)
         );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_7_ ( .D(n1913), .CLK(
        HCLK), .RSTB(n4901), .Q(AHB_I2C_WRAPPER_rx_data[7]), .QN(n4633) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte_reg_6_ ( .D(n1912), .CLK(
        HCLK), .RSTB(n4889), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[6]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_30_ ( .D(n1911), 
        .CLK(HCLK), .RSTB(n4889), .Q(AHB_I2C_WRAPPER_rx_data[30]), .QN(n4658)
         );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_22_ ( .D(n1910), 
        .CLK(HCLK), .RSTB(n4889), .Q(AHB_I2C_WRAPPER_rx_data[22]), .QN(n4648)
         );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_14_ ( .D(n1909), 
        .CLK(HCLK), .RSTB(n4889), .Q(AHB_I2C_WRAPPER_rx_data[14]), .QN(n4640)
         );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_6_ ( .D(n1908), .CLK(
        HCLK), .RSTB(n4901), .Q(AHB_I2C_WRAPPER_rx_data[6]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte_reg_5_ ( .D(n1907), .CLK(
        HCLK), .RSTB(n4889), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[5]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_29_ ( .D(n1906), 
        .CLK(HCLK), .RSTB(n4901), .Q(AHB_I2C_WRAPPER_rx_data[29]), .QN(n4657)
         );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_21_ ( .D(n1905), 
        .CLK(HCLK), .RSTB(n4901), .Q(AHB_I2C_WRAPPER_rx_data[21]), .QN(n4647)
         );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_13_ ( .D(n1904), 
        .CLK(HCLK), .RSTB(n4889), .Q(AHB_I2C_WRAPPER_rx_data[13]), .QN(n4639)
         );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_5_ ( .D(n1903), .CLK(
        HCLK), .RSTB(n4912), .Q(AHB_I2C_WRAPPER_rx_data[5]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte_reg_4_ ( .D(n1902), .CLK(
        HCLK), .RSTB(n4889), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[4]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_28_ ( .D(n1901), 
        .CLK(HCLK), .RSTB(n4912), .Q(AHB_I2C_WRAPPER_rx_data[28]), .QN(n4655)
         );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_20_ ( .D(n1900), 
        .CLK(HCLK), .RSTB(n4889), .Q(AHB_I2C_WRAPPER_rx_data[20]), .QN(n4646)
         );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_12_ ( .D(n1899), 
        .CLK(HCLK), .RSTB(n4889), .Q(AHB_I2C_WRAPPER_rx_data[12]), .QN(n4638)
         );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_4_ ( .D(n1898), .CLK(
        HCLK), .RSTB(n4912), .Q(AHB_I2C_WRAPPER_rx_data[4]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte_reg_3_ ( .D(n1897), .CLK(
        HCLK), .RSTB(n4889), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[3]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_27_ ( .D(n1896), 
        .CLK(HCLK), .RSTB(n4912), .Q(AHB_I2C_WRAPPER_rx_data[27]), .QN(n4653)
         );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_19_ ( .D(n1895), 
        .CLK(HCLK), .RSTB(n4889), .Q(AHB_I2C_WRAPPER_rx_data[19]), .QN(n4645)
         );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_11_ ( .D(n1894), 
        .CLK(HCLK), .RSTB(n4889), .Q(AHB_I2C_WRAPPER_rx_data[11]), .QN(n4637)
         );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_3_ ( .D(n1893), .CLK(
        HCLK), .RSTB(n4912), .Q(AHB_I2C_WRAPPER_rx_data[3]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte_reg_2_ ( .D(n1892), .CLK(
        HCLK), .RSTB(n4889), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[2]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_26_ ( .D(n1891), 
        .CLK(HCLK), .RSTB(n4912), .Q(AHB_I2C_WRAPPER_rx_data[26]), .QN(n4652)
         );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_18_ ( .D(n1890), 
        .CLK(HCLK), .RSTB(n4889), .Q(AHB_I2C_WRAPPER_rx_data[18]), .QN(n4644)
         );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_10_ ( .D(n1889), 
        .CLK(HCLK), .RSTB(n4913), .Q(AHB_I2C_WRAPPER_rx_data[10]), .QN(n4636)
         );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_2_ ( .D(n1888), .CLK(
        HCLK), .RSTB(n4912), .Q(AHB_I2C_WRAPPER_rx_data[2]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_25_ ( .D(n1886), 
        .CLK(HCLK), .RSTB(n4912), .Q(AHB_I2C_WRAPPER_rx_data[25]), .QN(n4651)
         );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_17_ ( .D(n1885), 
        .CLK(HCLK), .RSTB(n4913), .Q(AHB_I2C_WRAPPER_rx_data[17]), .QN(n4643)
         );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_9_ ( .D(n1884), .CLK(
        HCLK), .RSTB(n4913), .Q(AHB_I2C_WRAPPER_rx_data[9]), .QN(n4635) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_1_ ( .D(n1883), .CLK(
        HCLK), .RSTB(n4901), .Q(AHB_I2C_WRAPPER_rx_data[1]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_24_ ( .D(n1881), 
        .CLK(HCLK), .RSTB(n4901), .Q(AHB_I2C_WRAPPER_rx_data[24]), .QN(n4650)
         );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_16_ ( .D(n1880), 
        .CLK(HCLK), .RSTB(n4889), .Q(AHB_I2C_WRAPPER_rx_data[16]), .QN(n4642)
         );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_8_ ( .D(n1879), .CLK(
        HCLK), .RSTB(n4913), .Q(AHB_I2C_WRAPPER_rx_data[8]), .QN(n4634) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_data_reg_0_ ( .D(n1878), .CLK(
        HCLK), .RSTB(n4901), .Q(AHB_I2C_WRAPPER_rx_data[0]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_error_reg ( .D(n1877), .CLK(HCLK), 
        .RSTB(n4901), .Q(AHB_I2C_WRAPPER_error) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_STATE_reg_0_ ( .D(
        n1876), .CLK(HCLK), .RSTB(n4897), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_STATE[0]), .QN(n4730) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_STATE_reg_1_ ( .D(
        n1875), .CLK(HCLK), .RSTB(n4884), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_STATE[1]), .QN(n4729) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Counter_reg_1_ ( 
        .D(n1868), .CLK(HCLK), .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Counter[1]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Counter_reg_0_ ( 
        .D(n1867), .CLK(HCLK), .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Counter[0]), .QN(
        n4738) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter_reg_0_ ( 
        .D(n1855), .CLK(HCLK), .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[0]), .QN(
        n4735) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter_reg_2_ ( 
        .D(n1853), .CLK(HCLK), .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[2]), .QN(
        n4733) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter_reg_1_ ( 
        .D(n1851), .CLK(HCLK), .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter[1]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter_reg_2_ ( 
        .D(n1850), .CLK(HCLK), .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter[2]), .QN(
        n4736) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter_reg_3_ ( 
        .D(n1849), .CLK(HCLK), .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter[3]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_rx_valid_reg ( .D(
        n1848), .CLK(HCLK), .RSTB(n4879), .Q(AHB_UART_WRAPPER_rx_valid), .QN(
        n4737) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_0_ ( .D(
        n1847), .CLK(HCLK), .RSTB(n4879), .Q(AHB_UART_WRAPPER_rx_data[0]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_1_ ( .D(
        n1846), .CLK(HCLK), .RSTB(n4879), .Q(AHB_UART_WRAPPER_rx_data[1]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_2_ ( .D(
        n1845), .CLK(HCLK), .RSTB(n4879), .Q(AHB_UART_WRAPPER_rx_data[2]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_3_ ( .D(
        n1844), .CLK(HCLK), .RSTB(n4879), .Q(AHB_UART_WRAPPER_rx_data[3]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_4_ ( .D(
        n1843), .CLK(HCLK), .RSTB(n4879), .Q(AHB_UART_WRAPPER_rx_data[4]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_5_ ( .D(
        n1842), .CLK(HCLK), .RSTB(n4879), .Q(AHB_UART_WRAPPER_rx_data[5]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_6_ ( .D(
        n1841), .CLK(HCLK), .RSTB(n4879), .Q(AHB_UART_WRAPPER_rx_data[6]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_7_ ( .D(
        n1840), .CLK(HCLK), .RSTB(n4879), .Q(AHB_UART_WRAPPER_rx_data[7]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_8_ ( .D(
        n1839), .CLK(HCLK), .RSTB(n4879), .Q(AHB_UART_WRAPPER_rx_data[8]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_9_ ( .D(
        n1838), .CLK(HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_rx_data[9]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_10_ ( 
        .D(n1837), .CLK(HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_rx_data[10])
         );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_11_ ( 
        .D(n1836), .CLK(HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_rx_data[11])
         );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_12_ ( 
        .D(n1835), .CLK(HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_rx_data[12])
         );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_13_ ( 
        .D(n1834), .CLK(HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_rx_data[13])
         );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_14_ ( 
        .D(n1833), .CLK(HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_rx_data[14])
         );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_15_ ( 
        .D(n1832), .CLK(HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_rx_data[15])
         );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_16_ ( 
        .D(n1831), .CLK(HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_rx_data[16])
         );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_17_ ( 
        .D(n1830), .CLK(HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_rx_data[17])
         );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_18_ ( 
        .D(n1829), .CLK(HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_rx_data[18])
         );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_19_ ( 
        .D(n1828), .CLK(HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_rx_data[19])
         );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_20_ ( 
        .D(n1827), .CLK(HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_rx_data[20])
         );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_21_ ( 
        .D(n1826), .CLK(HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_rx_data[21])
         );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_22_ ( 
        .D(n1825), .CLK(HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_rx_data[22])
         );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_23_ ( 
        .D(n1824), .CLK(HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_rx_data[23])
         );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_24_ ( 
        .D(n1823), .CLK(HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_rx_data[24])
         );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_25_ ( 
        .D(n1822), .CLK(HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_rx_data[25])
         );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_26_ ( 
        .D(n1821), .CLK(HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_rx_data[26])
         );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_27_ ( 
        .D(n1820), .CLK(HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_rx_data[27])
         );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_28_ ( 
        .D(n1819), .CLK(HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_rx_data[28])
         );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_29_ ( 
        .D(n1818), .CLK(HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_rx_data[29])
         );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_30_ ( 
        .D(n1817), .CLK(HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_rx_data[30])
         );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_RXDATA_reg_31_ ( 
        .D(n1816), .CLK(HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_rx_data[31])
         );
  DFFASX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_HREADYOUT_reg ( .D(n1815), .CLK(
        HCLK), .SETB(n4892), .Q(sram_readyout) );
  DFFASX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_HREADYOUT_reg ( .D(n1814), .CLK(
        HCLK), .SETB(n4892), .Q(uart_readyout) );
  DFFASX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_HREADYOUT_reg ( .D(n1813), .CLK(HCLK), .SETB(n4892), .Q(spi_readyout) );
  DFFASX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_HREADYOUT_reg ( .D(n1808), .CLK(HCLK), .SETB(n4898), .Q(i2c_readyout) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_0_ ( .D(n2636), .CLK(HCLK), 
        .RSTB(n4887), .Q(AHB_UART_WRAPPER_tx_data[0]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_1_ ( .D(n2635), .CLK(HCLK), 
        .RSTB(n4887), .Q(AHB_UART_WRAPPER_tx_data[1]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_5_ ( .D(n2631), .CLK(HCLK), 
        .RSTB(n4887), .Q(AHB_UART_WRAPPER_tx_data[5]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_6_ ( .D(n2630), .CLK(HCLK), 
        .RSTB(n4887), .Q(AHB_UART_WRAPPER_tx_data[6]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_7_ ( .D(n2629), .CLK(HCLK), 
        .RSTB(n4899), .Q(AHB_UART_WRAPPER_tx_data[7]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_8_ ( .D(n2628), .CLK(HCLK), 
        .RSTB(n4900), .Q(AHB_UART_WRAPPER_tx_data[8]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_9_ ( .D(n2627), .CLK(HCLK), 
        .RSTB(n4900), .Q(AHB_UART_WRAPPER_tx_data[9]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_10_ ( .D(n2626), .CLK(HCLK), .RSTB(n4900), .Q(AHB_UART_WRAPPER_tx_data[10]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_11_ ( .D(n2625), .CLK(HCLK), .RSTB(n4900), .Q(AHB_UART_WRAPPER_tx_data[11]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_12_ ( .D(n2624), .CLK(HCLK), .RSTB(n4899), .Q(AHB_UART_WRAPPER_tx_data[12]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_13_ ( .D(n2623), .CLK(HCLK), .RSTB(n4899), .Q(AHB_UART_WRAPPER_tx_data[13]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_15_ ( .D(n2621), .CLK(HCLK), .RSTB(n4899), .Q(AHB_UART_WRAPPER_tx_data[15]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_16_ ( .D(n2620), .CLK(HCLK), .RSTB(n4899), .Q(AHB_UART_WRAPPER_tx_data[16]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_18_ ( .D(n2618), .CLK(HCLK), .RSTB(n4899), .Q(AHB_UART_WRAPPER_tx_data[18]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_22_ ( .D(n2614), .CLK(HCLK), .RSTB(n4899), .Q(AHB_UART_WRAPPER_tx_data[22]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_26_ ( .D(n2610), .CLK(HCLK), .RSTB(n4899), .Q(AHB_UART_WRAPPER_tx_data[26]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_27_ ( .D(n2609), .CLK(HCLK), .RSTB(n4899), .Q(AHB_UART_WRAPPER_tx_data[27]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_28_ ( .D(n2608), .CLK(HCLK), .RSTB(n4900), .Q(AHB_UART_WRAPPER_tx_data[28]), .QN(n4616) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_29_ ( .D(n2607), .CLK(HCLK), .RSTB(n4887), .Q(AHB_UART_WRAPPER_tx_data[29]), .QN(n4617) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_30_ ( .D(n2606), .CLK(HCLK), .RSTB(n4887), .Q(AHB_UART_WRAPPER_tx_data[30]), .QN(n4618) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_31_ ( .D(n2605), .CLK(HCLK), .RSTB(n4887), .Q(AHB_UART_WRAPPER_tx_data[31]), .QN(n4619) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_rx_valid_clr_reg ( .D(n5128), .CLK(
        HCLK), .RSTB(n4879), .Q(AHB_UART_WRAPPER_rx_valid_clr) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_byte_size_reg_0_ ( .D(n2604), .CLK(
        HCLK), .RSTB(n4903), .Q(AHB_UART_WRAPPER_tx_byte_size[0]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_byte_size_reg_1_ ( .D(n2603), .CLK(
        HCLK), .RSTB(n4887), .Q(AHB_UART_WRAPPER_tx_byte_size[1]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_tx_byte_size_reg_2_ ( .D(n2602), .CLK(
        HCLK), .RSTB(n4887), .Q(AHB_UART_WRAPPER_tx_byte_size[2]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_rx_byte_size_reg_0_ ( .D(n2601), .CLK(
        HCLK), .RSTB(n4879), .Q(AHB_UART_WRAPPER_rx_byte_size[0]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_rx_byte_size_reg_1_ ( .D(n2600), .CLK(
        HCLK), .RSTB(n4879), .Q(AHB_UART_WRAPPER_rx_byte_size[1]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_rx_byte_size_reg_2_ ( .D(n2599), .CLK(
        HCLK), .RSTB(n4903), .Q(AHB_UART_WRAPPER_rx_byte_size[2]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_28_ ( .D(n2570), .CLK(HCLK), 
        .RSTB(n4897), .Q(AHB_SPI_WRAPPER_sl_rdata[28]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_29_ ( .D(n2569), .CLK(HCLK), 
        .RSTB(n4897), .Q(AHB_SPI_WRAPPER_sl_rdata[29]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_30_ ( .D(n2568), .CLK(HCLK), 
        .RSTB(n4897), .Q(AHB_SPI_WRAPPER_sl_rdata[30]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_31_ ( .D(n2567), .CLK(HCLK), 
        .RSTB(n4882), .Q(AHB_SPI_WRAPPER_sl_rdata[31]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_0_ ( .D(n2566), .CLK(HCLK), 
        .RSTB(n4884), .Q(AHB_SPI_WRAPPER_tx_data[0]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_1_ ( .D(n2565), .CLK(HCLK), 
        .RSTB(n4884), .Q(AHB_SPI_WRAPPER_tx_data[1]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_2_ ( .D(n2564), .CLK(HCLK), 
        .RSTB(n4884), .Q(AHB_SPI_WRAPPER_tx_data[2]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_3_ ( .D(n2563), .CLK(HCLK), 
        .RSTB(n4884), .Q(AHB_SPI_WRAPPER_tx_data[3]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_4_ ( .D(n2562), .CLK(HCLK), 
        .RSTB(n4884), .Q(AHB_SPI_WRAPPER_tx_data[4]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_5_ ( .D(n2561), .CLK(HCLK), 
        .RSTB(n4893), .Q(AHB_SPI_WRAPPER_tx_data[5]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_6_ ( .D(n2560), .CLK(HCLK), 
        .RSTB(n4884), .Q(AHB_SPI_WRAPPER_tx_data[6]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_7_ ( .D(n2559), .CLK(HCLK), 
        .RSTB(n4884), .Q(AHB_SPI_WRAPPER_tx_data[7]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_8_ ( .D(n2558), .CLK(HCLK), 
        .RSTB(n4897), .Q(AHB_SPI_WRAPPER_tx_data[8]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_9_ ( .D(n2557), .CLK(HCLK), 
        .RSTB(n4897), .Q(AHB_SPI_WRAPPER_tx_data[9]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_10_ ( .D(n2556), .CLK(HCLK), 
        .RSTB(n4882), .Q(AHB_SPI_WRAPPER_tx_data[10]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_11_ ( .D(n2555), .CLK(HCLK), 
        .RSTB(n4882), .Q(AHB_SPI_WRAPPER_tx_data[11]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_12_ ( .D(n2554), .CLK(HCLK), 
        .RSTB(n4882), .Q(AHB_SPI_WRAPPER_tx_data[12]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_13_ ( .D(n2553), .CLK(HCLK), 
        .RSTB(n4882), .Q(AHB_SPI_WRAPPER_tx_data[13]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_14_ ( .D(n2552), .CLK(HCLK), 
        .RSTB(n4893), .Q(AHB_SPI_WRAPPER_tx_data[14]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_15_ ( .D(n2551), .CLK(HCLK), 
        .RSTB(n4882), .Q(AHB_SPI_WRAPPER_tx_data[15]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_16_ ( .D(n2550), .CLK(HCLK), 
        .RSTB(n4882), .Q(AHB_SPI_WRAPPER_tx_data[16]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_17_ ( .D(n2549), .CLK(HCLK), 
        .RSTB(n4882), .Q(AHB_SPI_WRAPPER_tx_data[17]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_18_ ( .D(n2548), .CLK(HCLK), 
        .RSTB(n4882), .Q(AHB_SPI_WRAPPER_tx_data[18]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_19_ ( .D(n2547), .CLK(HCLK), 
        .RSTB(n4908), .Q(AHB_SPI_WRAPPER_tx_data[19]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_20_ ( .D(n2546), .CLK(HCLK), 
        .RSTB(n4908), .Q(AHB_SPI_WRAPPER_tx_data[20]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_22_ ( .D(n2544), .CLK(HCLK), 
        .RSTB(n4907), .Q(AHB_SPI_WRAPPER_tx_data[22]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_24_ ( .D(n2542), .CLK(HCLK), 
        .RSTB(n4882), .Q(AHB_SPI_WRAPPER_tx_data[24]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_25_ ( .D(n2541), .CLK(HCLK), 
        .RSTB(n4893), .Q(AHB_SPI_WRAPPER_tx_data[25]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_26_ ( .D(n2540), .CLK(HCLK), 
        .RSTB(n4882), .Q(AHB_SPI_WRAPPER_tx_data[26]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_28_ ( .D(n2538), .CLK(HCLK), 
        .RSTB(n4893), .Q(AHB_SPI_WRAPPER_tx_data[28]), .QN(n4627) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_29_ ( .D(n2537), .CLK(HCLK), 
        .RSTB(n4893), .Q(AHB_SPI_WRAPPER_tx_data[29]), .QN(n4628) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_30_ ( .D(n2536), .CLK(HCLK), 
        .RSTB(n4893), .Q(AHB_SPI_WRAPPER_tx_data[30]), .QN(n4629) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_31_ ( .D(n2535), .CLK(HCLK), 
        .RSTB(n4907), .Q(AHB_SPI_WRAPPER_tx_data[31]), .QN(n4630) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_slave_select_reg_1_ ( .D(n2533), .CLK(
        HCLK), .RSTB(n4884), .Q(AHB_SPI_WRAPPER_slave_select[1]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_byte_size_reg_0_ ( .D(n2532), .CLK(
        HCLK), .RSTB(n4884), .Q(AHB_SPI_WRAPPER_tx_byte_size[0]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_byte_size_reg_1_ ( .D(n2531), .CLK(
        HCLK), .RSTB(n4884), .Q(AHB_SPI_WRAPPER_tx_byte_size[1]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_tx_byte_size_reg_2_ ( .D(n2530), .CLK(
        HCLK), .RSTB(n4884), .Q(AHB_SPI_WRAPPER_tx_byte_size[2]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_rx_byte_size_reg_0_ ( .D(n2529), .CLK(
        HCLK), .RSTB(n4884), .Q(AHB_SPI_WRAPPER_rx_byte_size[0]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_rx_byte_size_reg_1_ ( .D(n2528), .CLK(
        HCLK), .RSTB(n4884), .Q(AHB_SPI_WRAPPER_rx_byte_size[1]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_REG_rx_byte_size_reg_2_ ( .D(n2527), .CLK(
        HCLK), .RSTB(n4884), .Q(AHB_SPI_WRAPPER_rx_byte_size[2]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_error_reg ( .D(n2526), .CLK(HCLK), 
        .RSTB(n4906), .Q(AHB_SPI_WRAPPER_error), .QN(n4625) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_0_ ( .D(n2525), .CLK(HCLK), 
        .RSTB(n4905), .Q(AHB_I2C_WRAPPER_sl_rdata[0]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_2_ ( .D(n2523), .CLK(HCLK), 
        .RSTB(n4912), .Q(AHB_I2C_WRAPPER_sl_rdata[2]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_4_ ( .D(n2521), .CLK(HCLK), 
        .RSTB(n4888), .Q(AHB_I2C_WRAPPER_sl_rdata[4]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_5_ ( .D(n2520), .CLK(HCLK), 
        .RSTB(n4888), .Q(AHB_I2C_WRAPPER_sl_rdata[5]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_6_ ( .D(n2519), .CLK(HCLK), 
        .RSTB(n4888), .Q(AHB_I2C_WRAPPER_sl_rdata[6]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_7_ ( .D(n2518), .CLK(HCLK), 
        .RSTB(n4913), .Q(AHB_I2C_WRAPPER_sl_rdata[7]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_10_ ( .D(n2515), .CLK(HCLK), 
        .RSTB(n4913), .Q(AHB_I2C_WRAPPER_sl_rdata[10]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_11_ ( .D(n2514), .CLK(HCLK), 
        .RSTB(n4889), .Q(AHB_I2C_WRAPPER_sl_rdata[11]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_12_ ( .D(n2513), .CLK(HCLK), 
        .RSTB(n4888), .Q(AHB_I2C_WRAPPER_sl_rdata[12]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_13_ ( .D(n2512), .CLK(HCLK), 
        .RSTB(n4888), .Q(AHB_I2C_WRAPPER_sl_rdata[13]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_14_ ( .D(n2511), .CLK(HCLK), 
        .RSTB(n4905), .Q(AHB_I2C_WRAPPER_sl_rdata[14]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_15_ ( .D(n2510), .CLK(HCLK), 
        .RSTB(n4905), .Q(AHB_I2C_WRAPPER_sl_rdata[15]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_16_ ( .D(n2509), .CLK(HCLK), 
        .RSTB(n4905), .Q(AHB_I2C_WRAPPER_sl_rdata[16]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_23_ ( .D(n2502), .CLK(HCLK), 
        .RSTB(n4905), .Q(AHB_I2C_WRAPPER_sl_rdata[23]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_6_ ( .D(n2484), .CLK(HCLK), 
        .RSTB(n4889), .Q(AHB_I2C_WRAPPER_tx_data[6]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_7_ ( .D(n2483), .CLK(HCLK), 
        .RSTB(n4891), .Q(AHB_I2C_WRAPPER_tx_data[7]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_8_ ( .D(n2482), .CLK(HCLK), 
        .RSTB(n4899), .Q(AHB_I2C_WRAPPER_tx_data[8]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_9_ ( .D(n2481), .CLK(HCLK), 
        .RSTB(n4899), .Q(AHB_I2C_WRAPPER_tx_data[9]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_10_ ( .D(n2480), .CLK(HCLK), 
        .RSTB(n4891), .Q(AHB_I2C_WRAPPER_tx_data[10]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_14_ ( .D(n2476), .CLK(HCLK), 
        .RSTB(n4913), .Q(AHB_I2C_WRAPPER_tx_data[14]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_21_ ( .D(n2469), .CLK(HCLK), 
        .RSTB(n4899), .Q(AHB_I2C_WRAPPER_tx_data[21]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_24_ ( .D(n2466), .CLK(HCLK), 
        .RSTB(n4912), .Q(AHB_I2C_WRAPPER_tx_data[24]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_28_ ( .D(n2462), .CLK(HCLK), 
        .RSTB(n4912), .Q(AHB_I2C_WRAPPER_tx_data[28]), .QN(n4654) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_29_ ( .D(n2461), .CLK(HCLK), 
        .RSTB(n4912), .Q(AHB_I2C_WRAPPER_tx_data[29]), .QN(n4656) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_tx_byte_size_reg_0_ ( .D(n2458), .CLK(
        HCLK), .RSTB(n4901), .Q(AHB_I2C_WRAPPER_tx_byte_size[0]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_tx_byte_size_reg_1_ ( .D(n2457), .CLK(
        HCLK), .RSTB(n4901), .Q(AHB_I2C_WRAPPER_tx_byte_size[1]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_tx_byte_size_reg_2_ ( .D(n2456), .CLK(
        HCLK), .RSTB(n4901), .Q(AHB_I2C_WRAPPER_tx_byte_size[2]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_i2c_start_reg ( .D(
        AHB_I2C_WRAPPER_I2C_REG_N105), .CLK(HCLK), .RSTB(n4901), .Q(
        AHB_I2C_WRAPPER_i2c_start), .QN(n4712) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter_reg_5_ ( 
        .D(AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N37), .CLK(HCLK), 
        .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[5]), .QN(
        n4608) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter_reg_0_ ( 
        .D(AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N32), .CLK(HCLK), 
        .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[0]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter_reg_1_ ( 
        .D(AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N33), .CLK(HCLK), 
        .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[1]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter_reg_2_ ( 
        .D(AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N34), .CLK(HCLK), 
        .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[2]), .QN(
        n4607) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter_reg_3_ ( 
        .D(AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N35), .CLK(HCLK), 
        .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[3]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter_reg_4_ ( 
        .D(AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N36), .CLK(HCLK), 
        .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[4]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_Rxclk_en_reg ( 
        .D(AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N63), .CLK(HCLK), 
        .RSTB(n4879), .Q(AHB_UART_WRAPPER_UART_CONTROLLER_Rxclk_en) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter_reg_9_ ( 
        .D(AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N25), .CLK(HCLK), 
        .RSTB(n4896), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[9]), .QN(
        n4609) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter_reg_1_ ( 
        .D(AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N17), .CLK(HCLK), 
        .RSTB(n4911), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[1]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter_reg_2_ ( 
        .D(AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N18), .CLK(HCLK), 
        .RSTB(n4911), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[2]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter_reg_3_ ( 
        .D(AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N19), .CLK(HCLK), 
        .RSTB(n4911), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[3]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter_reg_4_ ( 
        .D(AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N20), .CLK(HCLK), 
        .RSTB(n4911), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[4]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter_reg_5_ ( 
        .D(AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N21), .CLK(HCLK), 
        .RSTB(n4894), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[5]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter_reg_6_ ( 
        .D(AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N22), .CLK(HCLK), 
        .RSTB(n4911), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[6]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter_reg_7_ ( 
        .D(AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N23), .CLK(HCLK), 
        .RSTB(n4911), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[7]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter_reg_8_ ( 
        .D(AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N24), .CLK(HCLK), 
        .RSTB(n4894), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[8]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_Txclk_en_reg ( 
        .D(n5133), .CLK(HCLK), .RSTB(n4884), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_Txclk_en), .QN(n4731) );
  NAND3X0_HVT U417 ( .A1(n5156), .A2(I2C_SDA), .A3(n362), .Y(n360) );
  AND2X1_HVT U440 ( .A1(n5505), .A2(I2C_SDA), .Y(n367) );
  NAND4X0_HVT U636 ( .A1(n5505), .A2(n5109), .A3(I2C_SDA), .A4(n5016), .Y(n497) );
  OA22X1_HVT U641 ( .A1(I2C_SDA), .A2(n502), .A3(n5016), .A4(n546), .Y(n506)
         );
  OR2X2_LVT U2634 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[1]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[0]), .Y(
        n2670) );
  INVX1_HVT U2635 ( .A(n2670), .Y(n2676) );
  NAND2X0_HVT U2636 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[0]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[1]), .Y(
        n3696) );
  INVX1_HVT U2637 ( .A(n3696), .Y(n2674) );
  NAND2X0_HVT U2638 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[4]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[5]), .Y(
        n2671) );
  NOR4X1_HVT U2639 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[1]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[3]), .A3(
        n4607), .A4(n2671), .Y(n2678) );
  OR2X2_LVT U2642 ( .A1(n2674), .A2(n2678), .Y(n2675) );
  OR2X2_LVT U2643 ( .A1(n2676), .A2(n2675), .Y(n2677) );
  INVX1_HVT U2644 ( .A(n2677), .Y(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N33) );
  NAND2X0_HVT U2645 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[0]), .A2(
        n2678), .Y(n3699) );
  INVX1_HVT U2646 ( .A(n3699), .Y(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N63) );
  NAND4X0_HVT U2647 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[0]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[1]), .A3(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[2]), .A4(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[3]), .Y(
        n3697) );
  INVX1_HVT U2648 ( .A(n3697), .Y(n2680) );
  OR2X2_LVT U2649 ( .A1(n2680), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[4]), .Y(
        n2679) );
  INVX1_HVT U2650 ( .A(n2679), .Y(n2684) );
  NAND2X0_HVT U2651 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[4]), .A2(
        n2680), .Y(n3700) );
  INVX1_HVT U2652 ( .A(n3700), .Y(n2682) );
  INVX1_HVT U2653 ( .A(n3699), .Y(n2681) );
  OR2X2_LVT U2654 ( .A1(n2682), .A2(n2681), .Y(n2683) );
  OR2X2_LVT U2655 ( .A1(n2684), .A2(n2683), .Y(n2685) );
  INVX1_HVT U2656 ( .A(n2685), .Y(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N36) );
  MUX21X1_HVT U2660 ( .A1(n5347), .A2(spi_rdata[11]), .S0(n5529), .Y(n2194) );
  MUX21X1_HVT U2661 ( .A1(n5382), .A2(spi_rdata[6]), .S0(n5529), .Y(n2199) );
  MUX21X1_HVT U2663 ( .A1(n5334), .A2(spi_rdata[19]), .S0(n5529), .Y(n2186) );
  MUX21X1_HVT U2664 ( .A1(AHB_SPI_WRAPPER_sl_rdata[18]), .A2(spi_rdata[18]), 
        .S0(n5529), .Y(n2187) );
  MUX21X1_HVT U2665 ( .A1(AHB_SPI_WRAPPER_sl_rdata[30]), .A2(spi_rdata[30]), 
        .S0(n5529), .Y(n2175) );
  MUX21X1_HVT U2666 ( .A1(AHB_SPI_WRAPPER_sl_rdata[5]), .A2(spi_rdata[5]), 
        .S0(n5529), .Y(n2200) );
  MUX21X1_HVT U2667 ( .A1(AHB_SPI_WRAPPER_sl_rdata[13]), .A2(spi_rdata[13]), 
        .S0(n5529), .Y(n2192) );
  MUX21X1_HVT U2668 ( .A1(AHB_SPI_WRAPPER_sl_rdata[4]), .A2(spi_rdata[4]), 
        .S0(n5529), .Y(n2201) );
  MUX21X1_HVT U2669 ( .A1(AHB_SPI_WRAPPER_sl_rdata[26]), .A2(spi_rdata[26]), 
        .S0(n5529), .Y(n2179) );
  MUX21X1_HVT U2670 ( .A1(n5355), .A2(spi_rdata[10]), .S0(n5529), .Y(n2195) );
  MUX21X1_HVT U2671 ( .A1(AHB_SPI_WRAPPER_sl_rdata[27]), .A2(spi_rdata[27]), 
        .S0(n5529), .Y(n2178) );
  MUX21X1_HVT U2672 ( .A1(AHB_SPI_WRAPPER_sl_rdata[20]), .A2(spi_rdata[20]), 
        .S0(n5529), .Y(n2185) );
  MUX21X1_HVT U2673 ( .A1(n5271), .A2(spi_rdata[8]), .S0(n5529), .Y(n2197) );
  MUX21X1_HVT U2674 ( .A1(n5339), .A2(spi_rdata[7]), .S0(n5529), .Y(n2198) );
  MUX21X1_HVT U2675 ( .A1(AHB_SPI_WRAPPER_sl_rdata[21]), .A2(spi_rdata[21]), 
        .S0(n5529), .Y(n2184) );
  MUX21X1_HVT U2676 ( .A1(AHB_SPI_WRAPPER_sl_rdata[28]), .A2(spi_rdata[28]), 
        .S0(n5529), .Y(n2177) );
  MUX21X1_HVT U2677 ( .A1(AHB_SPI_WRAPPER_sl_rdata[22]), .A2(spi_rdata[22]), 
        .S0(n5529), .Y(n2183) );
  MUX21X1_HVT U2678 ( .A1(n5269), .A2(spi_rdata[9]), .S0(n5529), .Y(n2196) );
  MUX21X1_HVT U2679 ( .A1(AHB_SPI_WRAPPER_sl_rdata[29]), .A2(spi_rdata[29]), 
        .S0(n5529), .Y(n2176) );
  MUX21X1_HVT U2680 ( .A1(AHB_SPI_WRAPPER_sl_rdata[23]), .A2(spi_rdata[23]), 
        .S0(n5529), .Y(n2182) );
  MUX21X1_HVT U2681 ( .A1(AHB_SPI_WRAPPER_sl_rdata[15]), .A2(spi_rdata[15]), 
        .S0(n5529), .Y(n2190) );
  MUX21X1_HVT U2682 ( .A1(AHB_SPI_WRAPPER_sl_rdata[24]), .A2(spi_rdata[24]), 
        .S0(n5529), .Y(n2181) );
  MUX21X1_HVT U2683 ( .A1(AHB_SPI_WRAPPER_sl_rdata[16]), .A2(spi_rdata[16]), 
        .S0(n5529), .Y(n2189) );
  MUX21X1_HVT U2684 ( .A1(AHB_SPI_WRAPPER_sl_rdata[17]), .A2(spi_rdata[17]), 
        .S0(n5529), .Y(n2188) );
  MUX21X1_HVT U2685 ( .A1(n5290), .A2(spi_rdata[14]), .S0(n5529), .Y(n2191) );
  MUX21X1_HVT U2686 ( .A1(AHB_SPI_WRAPPER_sl_rdata[25]), .A2(spi_rdata[25]), 
        .S0(n2686), .Y(n2180) );
  MUX21X1_HVT U2687 ( .A1(n5348), .A2(spi_rdata[12]), .S0(n5529), .Y(n2193) );
  MUX21X1_HVT U2688 ( .A1(AHB_SPI_WRAPPER_sl_rdata[31]), .A2(spi_rdata[31]), 
        .S0(n5529), .Y(n2174) );
  MUX21X1_HVT U2692 ( .A1(AHB_I2C_WRAPPER_sl_rdata[18]), .A2(i2c_rdata[18]), 
        .S0(n5532), .Y(n2002) );
  MUX21X1_HVT U2693 ( .A1(AHB_I2C_WRAPPER_sl_rdata[20]), .A2(i2c_rdata[20]), 
        .S0(n5532), .Y(n2000) );
  MUX21X1_HVT U2694 ( .A1(AHB_I2C_WRAPPER_sl_rdata[17]), .A2(i2c_rdata[17]), 
        .S0(n5532), .Y(n2003) );
  MUX21X1_HVT U2696 ( .A1(AHB_I2C_WRAPPER_sl_rdata[16]), .A2(i2c_rdata[16]), 
        .S0(n5532), .Y(n2004) );
  MUX21X1_HVT U2697 ( .A1(n5400), .A2(i2c_rdata[30]), .S0(n5532), .Y(n1990) );
  MUX21X1_HVT U2698 ( .A1(AHB_I2C_WRAPPER_sl_rdata[14]), .A2(i2c_rdata[14]), 
        .S0(n5532), .Y(n2006) );
  MUX21X1_HVT U2699 ( .A1(n5386), .A2(i2c_rdata[29]), .S0(n5532), .Y(n1991) );
  MUX21X1_HVT U2700 ( .A1(AHB_I2C_WRAPPER_sl_rdata[23]), .A2(i2c_rdata[23]), 
        .S0(n5383), .Y(n1997) );
  MUX21X1_HVT U2701 ( .A1(n5424), .A2(i2c_rdata[28]), .S0(n5532), .Y(n1992) );
  MUX21X1_HVT U2702 ( .A1(AHB_I2C_WRAPPER_sl_rdata[22]), .A2(i2c_rdata[22]), 
        .S0(n5532), .Y(n1998) );
  MUX21X1_HVT U2703 ( .A1(n5363), .A2(i2c_rdata[27]), .S0(n5532), .Y(n1993) );
  MUX21X1_HVT U2704 ( .A1(AHB_I2C_WRAPPER_sl_rdata[9]), .A2(i2c_rdata[9]), 
        .S0(n5532), .Y(n2011) );
  MUX21X1_HVT U2705 ( .A1(AHB_I2C_WRAPPER_sl_rdata[26]), .A2(i2c_rdata[26]), 
        .S0(n5532), .Y(n1994) );
  MUX21X1_HVT U2706 ( .A1(AHB_I2C_WRAPPER_sl_rdata[25]), .A2(i2c_rdata[25]), 
        .S0(n5532), .Y(n1995) );
  MUX21X1_HVT U2707 ( .A1(n5404), .A2(i2c_rdata[31]), .S0(n5532), .Y(n1989) );
  MUX21X1_HVT U2708 ( .A1(AHB_I2C_WRAPPER_sl_rdata[19]), .A2(i2c_rdata[19]), 
        .S0(n5532), .Y(n2001) );
  MUX21X1_HVT U2709 ( .A1(AHB_I2C_WRAPPER_sl_rdata[24]), .A2(i2c_rdata[24]), 
        .S0(n5532), .Y(n1996) );
  MUX21X1_HVT U2710 ( .A1(AHB_I2C_WRAPPER_sl_rdata[5]), .A2(i2c_rdata[5]), 
        .S0(n5532), .Y(n2015) );
  MUX21X1_HVT U2711 ( .A1(AHB_I2C_WRAPPER_sl_rdata[8]), .A2(i2c_rdata[8]), 
        .S0(n5532), .Y(n2012) );
  MUX21X1_HVT U2712 ( .A1(AHB_I2C_WRAPPER_sl_rdata[21]), .A2(i2c_rdata[21]), 
        .S0(n5532), .Y(n1999) );
  MUX21X1_HVT U2713 ( .A1(AHB_I2C_WRAPPER_sl_rdata[7]), .A2(i2c_rdata[7]), 
        .S0(n5532), .Y(n2013) );
  MUX21X1_HVT U2714 ( .A1(AHB_I2C_WRAPPER_sl_rdata[6]), .A2(i2c_rdata[6]), 
        .S0(n5383), .Y(n2014) );
  MUX21X1_HVT U2715 ( .A1(AHB_I2C_WRAPPER_sl_rdata[4]), .A2(i2c_rdata[4]), 
        .S0(n5383), .Y(n2016) );
  MUX21X1_HVT U2716 ( .A1(AHB_I2C_WRAPPER_sl_rdata[11]), .A2(i2c_rdata[11]), 
        .S0(n5532), .Y(n2009) );
  MUX21X1_HVT U2717 ( .A1(AHB_I2C_WRAPPER_sl_rdata[15]), .A2(i2c_rdata[15]), 
        .S0(n5532), .Y(n2005) );
  MUX21X1_HVT U2718 ( .A1(AHB_I2C_WRAPPER_sl_rdata[13]), .A2(i2c_rdata[13]), 
        .S0(n5532), .Y(n2007) );
  MUX21X1_HVT U2719 ( .A1(AHB_I2C_WRAPPER_sl_rdata[12]), .A2(i2c_rdata[12]), 
        .S0(n5532), .Y(n2008) );
  MUX21X1_HVT U2720 ( .A1(AHB_I2C_WRAPPER_sl_rdata[10]), .A2(i2c_rdata[10]), 
        .S0(n5532), .Y(n2010) );
  NAND2X0_HVT U2726 ( .A1(AHB_UART_WRAPPER_valid_trans), .A2(
        AHB_UART_WRAPPER_sl_write), .Y(n2693) );
  NAND4X0_HVT U2727 ( .A1(AHB_UART_WRAPPER_sl_wstrb[0]), .A2(
        AHB_UART_WRAPPER_sl_wstrb[1]), .A3(AHB_UART_WRAPPER_sl_wstrb[2]), .A4(
        AHB_UART_WRAPPER_sl_wstrb[3]), .Y(n2692) );
  NOR4X1_HVT U2728 ( .A1(AHB_UART_WRAPPER_sl_addr[0]), .A2(
        AHB_UART_WRAPPER_sl_addr[1]), .A3(n2693), .A4(n2692), .Y(n5515) );
  AND3X2_HVT U2729 ( .A1(AHB_UART_WRAPPER_sl_addr[2]), .A2(
        AHB_UART_WRAPPER_sl_addr[3]), .A3(n2719), .Y(n3693) );
  MUX21X1_HVT U2730 ( .A1(AHB_UART_WRAPPER_tx_byte_size[0]), .A2(n5325), .S0(
        n3693), .Y(n2604) );
  MUX21X1_HVT U2731 ( .A1(AHB_UART_WRAPPER_rx_byte_size[1]), .A2(n5418), .S0(
        n3693), .Y(n2600) );
  MUX21X1_HVT U2732 ( .A1(AHB_UART_WRAPPER_rx_byte_size[2]), .A2(n5354), .S0(
        n3693), .Y(n2599) );
  NAND2X0_HVT U2733 ( .A1(AHB_I2C_WRAPPER_valid_trans), .A2(
        AHB_I2C_WRAPPER_sl_write), .Y(n2695) );
  NAND4X0_HVT U2734 ( .A1(AHB_I2C_WRAPPER_sl_wstrb[0]), .A2(
        AHB_I2C_WRAPPER_sl_wstrb[1]), .A3(AHB_I2C_WRAPPER_sl_wstrb[2]), .A4(
        AHB_I2C_WRAPPER_sl_wstrb[3]), .Y(n2694) );
  NOR4X1_HVT U2735 ( .A1(AHB_I2C_WRAPPER_sl_addr[0]), .A2(
        AHB_I2C_WRAPPER_sl_addr[1]), .A3(n2695), .A4(n2694), .Y(n2715) );
  AND3X2_HVT U2736 ( .A1(AHB_I2C_WRAPPER_sl_addr[2]), .A2(
        AHB_I2C_WRAPPER_sl_addr[3]), .A3(n2715), .Y(n3695) );
  MUX21X1_HVT U2737 ( .A1(AHB_I2C_WRAPPER_rx_byte_size[0]), .A2(n5365), .S0(
        n5473), .Y(n2493) );
  MUX21X1_HVT U2738 ( .A1(AHB_UART_WRAPPER_tx_byte_size[2]), .A2(
        AHB_UART_WRAPPER_sl_wdata[6]), .S0(n3693), .Y(n2602) );
  MUX21X1_HVT U2739 ( .A1(AHB_I2C_WRAPPER_rx_byte_size[1]), .A2(n5395), .S0(
        n3695), .Y(n2492) );
  MUX21X1_HVT U2740 ( .A1(AHB_I2C_WRAPPER_tx_byte_size[2]), .A2(
        AHB_I2C_WRAPPER_sl_wdata[3]), .S0(n5473), .Y(n2456) );
  MUX21X1_HVT U2741 ( .A1(AHB_I2C_WRAPPER_rx_byte_size[2]), .A2(
        AHB_I2C_WRAPPER_sl_wdata[6]), .S0(n5473), .Y(n2491) );
  MUX21X1_HVT U2742 ( .A1(AHB_UART_WRAPPER_tx_byte_size[1]), .A2(
        AHB_UART_WRAPPER_sl_wdata[5]), .S0(n3693), .Y(n2603) );
  MUX21X1_HVT U2743 ( .A1(AHB_I2C_WRAPPER_tx_byte_size[1]), .A2(
        AHB_I2C_WRAPPER_sl_wdata[2]), .S0(n5473), .Y(n2457) );
  MUX21X1_HVT U2744 ( .A1(AHB_UART_WRAPPER_rx_byte_size[0]), .A2(n5350), .S0(
        n3693), .Y(n2601) );
  MUX21X1_HVT U2745 ( .A1(AHB_I2C_WRAPPER_tx_byte_size[0]), .A2(
        AHB_I2C_WRAPPER_sl_wdata[1]), .S0(n5473), .Y(n2458) );
  NAND2X0_HVT U2746 ( .A1(AHB_SPI_WRAPPER_valid_trans), .A2(
        AHB_SPI_WRAPPER_sl_write), .Y(n2697) );
  NAND4X0_HVT U2747 ( .A1(AHB_SPI_WRAPPER_sl_wstrb[0]), .A2(
        AHB_SPI_WRAPPER_sl_wstrb[1]), .A3(AHB_SPI_WRAPPER_sl_wstrb[2]), .A4(
        AHB_SPI_WRAPPER_sl_wstrb[3]), .Y(n2696) );
  NOR4X1_HVT U2748 ( .A1(AHB_SPI_WRAPPER_sl_addr[0]), .A2(
        AHB_SPI_WRAPPER_sl_addr[1]), .A3(n2697), .A4(n2696), .Y(n2713) );
  AND3X2_HVT U2749 ( .A1(AHB_SPI_WRAPPER_sl_addr[2]), .A2(
        AHB_SPI_WRAPPER_sl_addr[3]), .A3(n2713), .Y(n3694) );
  MUX21X1_HVT U2750 ( .A1(AHB_SPI_WRAPPER_tx_byte_size[1]), .A2(n5465), .S0(
        n3694), .Y(n2531) );
  MUX21X1_HVT U2751 ( .A1(AHB_SPI_WRAPPER_rx_byte_size[0]), .A2(n5469), .S0(
        n3694), .Y(n2529) );
  MUX21X1_HVT U2752 ( .A1(AHB_SPI_WRAPPER_rx_byte_size[1]), .A2(n5407), .S0(
        n3694), .Y(n2528) );
  MUX21X1_HVT U2753 ( .A1(AHB_SPI_WRAPPER_tx_byte_size[2]), .A2(n5401), .S0(
        n3694), .Y(n2530) );
  MUX21X1_HVT U2754 ( .A1(AHB_SPI_WRAPPER_slave_select[0]), .A2(n5403), .S0(
        n3694), .Y(n2534) );
  MUX21X1_HVT U2755 ( .A1(AHB_SPI_WRAPPER_tx_byte_size[0]), .A2(n5463), .S0(
        n3694), .Y(n2532) );
  MUX21X1_HVT U2756 ( .A1(AHB_SPI_WRAPPER_rx_byte_size[2]), .A2(n5472), .S0(
        n3694), .Y(n2527) );
  MUX21X1_HVT U2757 ( .A1(AHB_SPI_WRAPPER_slave_select[1]), .A2(n5413), .S0(
        n3694), .Y(n2533) );
  NAND2X0_HVT U2758 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[0]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[1]), .Y(
        n3703) );
  INVX1_HVT U2759 ( .A(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[2]), .Y(
        n3702) );
  NAND4X0_HVT U2760 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[8]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[6]), .A3(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[9]), .A4(
        n3702), .Y(n2698) );
  NOR4X1_HVT U2761 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[3]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[7]), .A3(
        n3703), .A4(n2698), .Y(n2700) );
  INVX1_HVT U2762 ( .A(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[4]), .Y(
        n2699) );
  INVX1_HVT U2765 ( .A(n3703), .Y(n3704) );
  NAND4X0_HVT U2766 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[4]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[2]), .A3(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[3]), .A4(
        n3704), .Y(n3706) );
  INVX1_HVT U2767 ( .A(n3706), .Y(n2702) );
  OR2X2_LVT U2768 ( .A1(n2702), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[5]), .Y(
        n2701) );
  INVX1_HVT U2769 ( .A(n2701), .Y(n2706) );
  NAND2X0_HVT U2770 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[5]), .A2(
        n2702), .Y(n2748) );
  INVX1_HVT U2771 ( .A(n2748), .Y(n2704) );
  OR2X2_LVT U2773 ( .A1(n2704), .A2(n5133), .Y(n2705) );
  OR2X2_LVT U2774 ( .A1(n2706), .A2(n2705), .Y(n2707) );
  INVX1_HVT U2775 ( .A(n2707), .Y(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N21) );
  MUX21X1_HVT U2780 ( .A1(n5477), .A2(uart_rdata[27]), .S0(n5530), .Y(n2266)
         );
  MUX21X1_HVT U2781 ( .A1(n5453), .A2(uart_rdata[19]), .S0(n5530), .Y(n2274)
         );
  MUX21X1_HVT U2782 ( .A1(n5480), .A2(uart_rdata[29]), .S0(n2708), .Y(n2264)
         );
  MUX21X1_HVT U2783 ( .A1(n5482), .A2(uart_rdata[30]), .S0(n5530), .Y(n2263)
         );
  MUX21X1_HVT U2784 ( .A1(n5467), .A2(uart_rdata[20]), .S0(n5530), .Y(n2273)
         );
  MUX21X1_HVT U2785 ( .A1(n5466), .A2(uart_rdata[18]), .S0(n5530), .Y(n2275)
         );
  MUX21X1_HVT U2786 ( .A1(n5475), .A2(uart_rdata[25]), .S0(n5530), .Y(n2268)
         );
  MUX21X1_HVT U2787 ( .A1(n5478), .A2(uart_rdata[26]), .S0(n5530), .Y(n2267)
         );
  MUX21X1_HVT U2788 ( .A1(n5479), .A2(uart_rdata[28]), .S0(n5530), .Y(n2265)
         );
  MUX21X1_HVT U2789 ( .A1(n5460), .A2(uart_rdata[21]), .S0(n5530), .Y(n2272)
         );
  MUX21X1_HVT U2790 ( .A1(n5481), .A2(uart_rdata[31]), .S0(n5530), .Y(n2262)
         );
  MUX21X1_HVT U2791 ( .A1(n5476), .A2(uart_rdata[23]), .S0(n5530), .Y(n2270)
         );
  MUX21X1_HVT U2792 ( .A1(n5456), .A2(uart_rdata[17]), .S0(n5530), .Y(n2276)
         );
  MUX21X1_HVT U2793 ( .A1(n5471), .A2(uart_rdata[22]), .S0(n5530), .Y(n2271)
         );
  MUX21X1_HVT U2796 ( .A1(n5457), .A2(uart_rdata[15]), .S0(n5530), .Y(n2278)
         );
  MUX21X1_HVT U2797 ( .A1(n5445), .A2(uart_rdata[13]), .S0(n5530), .Y(n2280)
         );
  MUX21X1_HVT U2798 ( .A1(n5434), .A2(uart_rdata[12]), .S0(n5530), .Y(n2281)
         );
  MUX21X1_HVT U2799 ( .A1(n5398), .A2(uart_rdata[7]), .S0(n5530), .Y(n2286) );
  MUX21X1_HVT U2800 ( .A1(n5419), .A2(uart_rdata[10]), .S0(n5530), .Y(n2283)
         );
  MUX21X1_HVT U2801 ( .A1(n5408), .A2(uart_rdata[9]), .S0(n5530), .Y(n2284) );
  MUX21X1_HVT U2802 ( .A1(n5448), .A2(uart_rdata[14]), .S0(n5530), .Y(n2279)
         );
  MUX21X1_HVT U2803 ( .A1(n5474), .A2(uart_rdata[24]), .S0(n5530), .Y(n2269)
         );
  MUX21X1_HVT U2804 ( .A1(n5405), .A2(uart_rdata[6]), .S0(n5530), .Y(n2287) );
  MUX21X1_HVT U2805 ( .A1(n5429), .A2(uart_rdata[5]), .S0(n5530), .Y(n2288) );
  MUX21X1_HVT U2806 ( .A1(n5420), .A2(uart_rdata[11]), .S0(n5530), .Y(n2282)
         );
  MUX21X1_HVT U2807 ( .A1(n5446), .A2(uart_rdata[16]), .S0(n5530), .Y(n2277)
         );
  MUX21X1_HVT U2808 ( .A1(n5396), .A2(uart_rdata[8]), .S0(n5530), .Y(n2285) );
  MUX21X1_HVT U2809 ( .A1(n5447), .A2(uart_rdata[4]), .S0(n5530), .Y(n2289) );
  INVX1_HVT U2810 ( .A(AHB_SPI_WRAPPER_sl_addr[2]), .Y(n3853) );
  MUX21X1_HVT U2814 ( .A1(AHB_SPI_WRAPPER_sl_wdata[25]), .A2(
        AHB_SPI_WRAPPER_tx_data[25]), .S0(n5528), .Y(n2541) );
  INVX1_HVT U2815 ( .A(AHB_I2C_WRAPPER_sl_addr[2]), .Y(n3949) );
  MUX21X1_HVT U2819 ( .A1(AHB_I2C_WRAPPER_sl_wdata[24]), .A2(
        AHB_I2C_WRAPPER_tx_data[24]), .S0(n2716), .Y(n2466) );
  MUX21X1_HVT U2820 ( .A1(AHB_I2C_WRAPPER_sl_wdata[22]), .A2(n5389), .S0(n2716), .Y(n2468) );
  MUX21X1_HVT U2821 ( .A1(AHB_I2C_WRAPPER_sl_wdata[25]), .A2(n5311), .S0(n2716), .Y(n2465) );
  MUX21X1_HVT U2822 ( .A1(AHB_SPI_WRAPPER_sl_wdata[27]), .A2(
        AHB_SPI_WRAPPER_tx_data[27]), .S0(n5528), .Y(n2539) );
  MUX21X1_HVT U2823 ( .A1(AHB_I2C_WRAPPER_sl_wdata[19]), .A2(n5284), .S0(n2716), .Y(n2471) );
  MUX21X1_HVT U2824 ( .A1(AHB_SPI_WRAPPER_sl_wdata[23]), .A2(
        AHB_SPI_WRAPPER_tx_data[23]), .S0(n5528), .Y(n2543) );
  MUX21X1_HVT U2825 ( .A1(AHB_SPI_WRAPPER_sl_wdata[26]), .A2(
        AHB_SPI_WRAPPER_tx_data[26]), .S0(n5528), .Y(n2540) );
  MUX21X1_HVT U2826 ( .A1(AHB_I2C_WRAPPER_sl_wdata[21]), .A2(
        AHB_I2C_WRAPPER_tx_data[21]), .S0(n2716), .Y(n2469) );
  MUX21X1_HVT U2828 ( .A1(n5395), .A2(AHB_I2C_WRAPPER_tx_data[5]), .S0(n2716), 
        .Y(n2485) );
  MUX21X1_HVT U2829 ( .A1(n5323), .A2(AHB_SPI_WRAPPER_tx_data[24]), .S0(n5528), 
        .Y(n2542) );
  MUX21X1_HVT U2830 ( .A1(AHB_I2C_WRAPPER_sl_wdata[23]), .A2(n5335), .S0(n2716), .Y(n2467) );
  MUX21X1_HVT U2831 ( .A1(AHB_I2C_WRAPPER_sl_wdata[26]), .A2(
        AHB_I2C_WRAPPER_tx_data[26]), .S0(n2716), .Y(n2464) );
  MUX21X1_HVT U2832 ( .A1(AHB_I2C_WRAPPER_sl_wdata[20]), .A2(n5409), .S0(n2716), .Y(n2470) );
  MUX21X1_HVT U2834 ( .A1(n5443), .A2(AHB_SPI_WRAPPER_tx_data[11]), .S0(n5528), 
        .Y(n2555) );
  MUX21X1_HVT U2835 ( .A1(n5432), .A2(AHB_SPI_WRAPPER_tx_data[22]), .S0(n5528), 
        .Y(n2544) );
  MUX21X1_HVT U2836 ( .A1(AHB_I2C_WRAPPER_sl_wdata[18]), .A2(
        AHB_I2C_WRAPPER_tx_data[18]), .S0(n2716), .Y(n2472) );
  MUX21X1_HVT U2837 ( .A1(AHB_SPI_WRAPPER_sl_wdata[21]), .A2(
        AHB_SPI_WRAPPER_tx_data[21]), .S0(n5528), .Y(n2545) );
  MUX21X1_HVT U2838 ( .A1(n5414), .A2(AHB_SPI_WRAPPER_tx_data[20]), .S0(n5528), 
        .Y(n2546) );
  MUX21X1_HVT U2839 ( .A1(AHB_SPI_WRAPPER_sl_wdata[19]), .A2(
        AHB_SPI_WRAPPER_tx_data[19]), .S0(n2714), .Y(n2547) );
  MUX21X1_HVT U2840 ( .A1(AHB_I2C_WRAPPER_sl_wdata[17]), .A2(
        AHB_I2C_WRAPPER_tx_data[17]), .S0(n2716), .Y(n2473) );
  MUX21X1_HVT U2841 ( .A1(n5437), .A2(AHB_SPI_WRAPPER_tx_data[18]), .S0(n5528), 
        .Y(n2548) );
  MUX21X1_HVT U2842 ( .A1(n5439), .A2(AHB_SPI_WRAPPER_tx_data[17]), .S0(n5528), 
        .Y(n2549) );
  MUX21X1_HVT U2843 ( .A1(n5428), .A2(AHB_SPI_WRAPPER_tx_data[16]), .S0(n5528), 
        .Y(n2550) );
  MUX21X1_HVT U2844 ( .A1(n5452), .A2(AHB_SPI_WRAPPER_tx_data[15]), .S0(n5528), 
        .Y(n2551) );
  MUX21X1_HVT U2845 ( .A1(AHB_I2C_WRAPPER_sl_wdata[16]), .A2(
        AHB_I2C_WRAPPER_tx_data[16]), .S0(n2716), .Y(n2474) );
  MUX21X1_HVT U2846 ( .A1(n5433), .A2(AHB_SPI_WRAPPER_tx_data[14]), .S0(n5528), 
        .Y(n2552) );
  MUX21X1_HVT U2847 ( .A1(AHB_I2C_WRAPPER_sl_wdata[0]), .A2(
        AHB_I2C_WRAPPER_tx_data[0]), .S0(n2716), .Y(n2490) );
  MUX21X1_HVT U2848 ( .A1(n5449), .A2(AHB_SPI_WRAPPER_tx_data[13]), .S0(n5528), 
        .Y(n2553) );
  MUX21X1_HVT U2849 ( .A1(AHB_I2C_WRAPPER_sl_wdata[15]), .A2(n5379), .S0(n2716), .Y(n2475) );
  MUX21X1_HVT U2850 ( .A1(AHB_I2C_WRAPPER_sl_wdata[1]), .A2(
        AHB_I2C_WRAPPER_tx_data[1]), .S0(n2716), .Y(n2489) );
  MUX21X1_HVT U2851 ( .A1(AHB_I2C_WRAPPER_sl_wdata[2]), .A2(
        AHB_I2C_WRAPPER_tx_data[2]), .S0(n2716), .Y(n2488) );
  MUX21X1_HVT U2852 ( .A1(AHB_I2C_WRAPPER_sl_wdata[14]), .A2(
        AHB_I2C_WRAPPER_tx_data[14]), .S0(n2716), .Y(n2476) );
  MUX21X1_HVT U2853 ( .A1(AHB_I2C_WRAPPER_sl_wdata[3]), .A2(
        AHB_I2C_WRAPPER_tx_data[3]), .S0(n2716), .Y(n2487) );
  MUX21X1_HVT U2854 ( .A1(n5431), .A2(AHB_SPI_WRAPPER_tx_data[12]), .S0(n5528), 
        .Y(n2554) );
  MUX21X1_HVT U2855 ( .A1(AHB_I2C_WRAPPER_sl_wdata[4]), .A2(
        AHB_I2C_WRAPPER_tx_data[4]), .S0(n2716), .Y(n2486) );
  MUX21X1_HVT U2856 ( .A1(AHB_I2C_WRAPPER_sl_wdata[13]), .A2(n5393), .S0(n2716), .Y(n2477) );
  MUX21X1_HVT U2857 ( .A1(AHB_I2C_WRAPPER_sl_wdata[12]), .A2(
        AHB_I2C_WRAPPER_tx_data[12]), .S0(n2716), .Y(n2478) );
  MUX21X1_HVT U2858 ( .A1(AHB_I2C_WRAPPER_sl_wdata[11]), .A2(n5337), .S0(n2716), .Y(n2479) );
  MUX21X1_HVT U2859 ( .A1(AHB_I2C_WRAPPER_sl_wdata[10]), .A2(
        AHB_I2C_WRAPPER_tx_data[10]), .S0(n2716), .Y(n2480) );
  MUX21X1_HVT U2860 ( .A1(AHB_I2C_WRAPPER_sl_wdata[9]), .A2(
        AHB_I2C_WRAPPER_tx_data[9]), .S0(n2716), .Y(n2481) );
  MUX21X1_HVT U2861 ( .A1(AHB_I2C_WRAPPER_sl_wdata[8]), .A2(
        AHB_I2C_WRAPPER_tx_data[8]), .S0(n2716), .Y(n2482) );
  MUX21X1_HVT U2862 ( .A1(AHB_I2C_WRAPPER_sl_wdata[7]), .A2(
        AHB_I2C_WRAPPER_tx_data[7]), .S0(n2716), .Y(n2483) );
  MUX21X1_HVT U2863 ( .A1(n5451), .A2(AHB_SPI_WRAPPER_tx_data[9]), .S0(n5528), 
        .Y(n2557) );
  MUX21X1_HVT U2864 ( .A1(AHB_I2C_WRAPPER_sl_wdata[6]), .A2(
        AHB_I2C_WRAPPER_tx_data[6]), .S0(n2716), .Y(n2484) );
  MUX21X1_HVT U2865 ( .A1(n5464), .A2(AHB_SPI_WRAPPER_tx_data[10]), .S0(n5528), 
        .Y(n2556) );
  MUX21X1_HVT U2869 ( .A1(AHB_UART_WRAPPER_sl_wdata[9]), .A2(
        AHB_UART_WRAPPER_tx_data[9]), .S0(n5512), .Y(n2627) );
  MUX21X1_HVT U2871 ( .A1(AHB_UART_WRAPPER_sl_wdata[23]), .A2(
        AHB_UART_WRAPPER_tx_data[23]), .S0(n2720), .Y(n2613) );
  MUX21X1_HVT U2872 ( .A1(n5418), .A2(AHB_UART_WRAPPER_tx_data[2]), .S0(n5512), 
        .Y(n2634) );
  MUX21X1_HVT U2873 ( .A1(AHB_UART_WRAPPER_sl_wdata[27]), .A2(
        AHB_UART_WRAPPER_tx_data[27]), .S0(n5512), .Y(n2609) );
  MUX21X1_HVT U2874 ( .A1(AHB_UART_WRAPPER_sl_wdata[15]), .A2(
        AHB_UART_WRAPPER_tx_data[15]), .S0(n5512), .Y(n2621) );
  MUX21X1_HVT U2875 ( .A1(AHB_UART_WRAPPER_sl_wdata[16]), .A2(
        AHB_UART_WRAPPER_tx_data[16]), .S0(n5512), .Y(n2620) );
  MUX21X1_HVT U2876 ( .A1(AHB_UART_WRAPPER_sl_wdata[24]), .A2(
        AHB_UART_WRAPPER_tx_data[24]), .S0(n2720), .Y(n2612) );
  MUX21X1_HVT U2877 ( .A1(AHB_UART_WRAPPER_sl_wdata[21]), .A2(
        AHB_UART_WRAPPER_tx_data[21]), .S0(n5512), .Y(n2615) );
  MUX21X1_HVT U2878 ( .A1(AHB_UART_WRAPPER_sl_wdata[11]), .A2(
        AHB_UART_WRAPPER_tx_data[11]), .S0(n5512), .Y(n2625) );
  MUX21X1_HVT U2879 ( .A1(AHB_I2C_WRAPPER_sl_wdata[27]), .A2(
        AHB_I2C_WRAPPER_tx_data[27]), .S0(n2716), .Y(n2463) );
  MUX21X1_HVT U2880 ( .A1(AHB_UART_WRAPPER_sl_wdata[19]), .A2(
        AHB_UART_WRAPPER_tx_data[19]), .S0(n5512), .Y(n2617) );
  MUX21X1_HVT U2881 ( .A1(AHB_UART_WRAPPER_sl_wdata[18]), .A2(
        AHB_UART_WRAPPER_tx_data[18]), .S0(n5512), .Y(n2618) );
  MUX21X1_HVT U2882 ( .A1(AHB_UART_WRAPPER_sl_wdata[22]), .A2(
        AHB_UART_WRAPPER_tx_data[22]), .S0(n5512), .Y(n2614) );
  MUX21X1_HVT U2883 ( .A1(AHB_UART_WRAPPER_sl_wdata[25]), .A2(
        AHB_UART_WRAPPER_tx_data[25]), .S0(n5512), .Y(n2611) );
  MUX21X1_HVT U2884 ( .A1(AHB_UART_WRAPPER_sl_wdata[13]), .A2(
        AHB_UART_WRAPPER_tx_data[13]), .S0(n5512), .Y(n2623) );
  MUX21X1_HVT U2885 ( .A1(AHB_UART_WRAPPER_sl_wdata[14]), .A2(
        AHB_UART_WRAPPER_tx_data[14]), .S0(n2720), .Y(n2622) );
  MUX21X1_HVT U2886 ( .A1(AHB_UART_WRAPPER_sl_wdata[7]), .A2(
        AHB_UART_WRAPPER_tx_data[7]), .S0(n5512), .Y(n2629) );
  MUX21X1_HVT U2887 ( .A1(AHB_UART_WRAPPER_sl_wdata[20]), .A2(
        AHB_UART_WRAPPER_tx_data[20]), .S0(n5512), .Y(n2616) );
  MUX21X1_HVT U2888 ( .A1(n5324), .A2(AHB_UART_WRAPPER_tx_data[26]), .S0(n5512), .Y(n2610) );
  MUX21X1_HVT U2889 ( .A1(n5463), .A2(AHB_SPI_WRAPPER_tx_data[1]), .S0(n5528), 
        .Y(n2565) );
  MUX21X1_HVT U2890 ( .A1(n5413), .A2(AHB_SPI_WRAPPER_tx_data[8]), .S0(n5528), 
        .Y(n2558) );
  MUX21X1_HVT U2891 ( .A1(n5401), .A2(AHB_SPI_WRAPPER_tx_data[3]), .S0(n5528), 
        .Y(n2563) );
  MUX21X1_HVT U2892 ( .A1(n5350), .A2(AHB_UART_WRAPPER_tx_data[1]), .S0(n5512), 
        .Y(n2635) );
  MUX21X1_HVT U2893 ( .A1(n5469), .A2(AHB_SPI_WRAPPER_tx_data[4]), .S0(n5528), 
        .Y(n2562) );
  MUX21X1_HVT U2894 ( .A1(n5356), .A2(AHB_UART_WRAPPER_tx_data[0]), .S0(n5512), 
        .Y(n2636) );
  MUX21X1_HVT U2895 ( .A1(AHB_UART_WRAPPER_sl_wdata[10]), .A2(
        AHB_UART_WRAPPER_tx_data[10]), .S0(n5512), .Y(n2626) );
  MUX21X1_HVT U2896 ( .A1(AHB_UART_WRAPPER_sl_wdata[17]), .A2(
        AHB_UART_WRAPPER_tx_data[17]), .S0(n5512), .Y(n2619) );
  MUX21X1_HVT U2897 ( .A1(AHB_UART_WRAPPER_sl_wdata[12]), .A2(
        AHB_UART_WRAPPER_tx_data[12]), .S0(n5512), .Y(n2624) );
  MUX21X1_HVT U2898 ( .A1(n5472), .A2(AHB_SPI_WRAPPER_tx_data[6]), .S0(n5528), 
        .Y(n2560) );
  MUX21X1_HVT U2899 ( .A1(n5354), .A2(AHB_UART_WRAPPER_tx_data[3]), .S0(n5512), 
        .Y(n2633) );
  MUX21X1_HVT U2900 ( .A1(AHB_UART_WRAPPER_sl_wdata[8]), .A2(
        AHB_UART_WRAPPER_tx_data[8]), .S0(n5512), .Y(n2628) );
  MUX21X1_HVT U2901 ( .A1(n5325), .A2(AHB_UART_WRAPPER_tx_data[4]), .S0(n5512), 
        .Y(n2632) );
  MUX21X1_HVT U2902 ( .A1(AHB_UART_WRAPPER_sl_wdata[6]), .A2(
        AHB_UART_WRAPPER_tx_data[6]), .S0(n5512), .Y(n2630) );
  MUX21X1_HVT U2903 ( .A1(n5462), .A2(AHB_SPI_WRAPPER_tx_data[0]), .S0(n5528), 
        .Y(n2566) );
  MUX21X1_HVT U2904 ( .A1(AHB_UART_WRAPPER_sl_wdata[5]), .A2(
        AHB_UART_WRAPPER_tx_data[5]), .S0(n5512), .Y(n2631) );
  MUX21X1_HVT U2905 ( .A1(n5465), .A2(AHB_SPI_WRAPPER_tx_data[2]), .S0(n5528), 
        .Y(n2564) );
  MUX21X1_HVT U2906 ( .A1(n5407), .A2(AHB_SPI_WRAPPER_tx_data[5]), .S0(n5528), 
        .Y(n2561) );
  MUX21X1_HVT U2907 ( .A1(n5403), .A2(AHB_SPI_WRAPPER_tx_data[7]), .S0(n5528), 
        .Y(n2559) );
  OR3X1_HVT U2908 ( .A1(n4664), .A2(n4665), .A3(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[2]), .Y(n4234) );
  NAND2X0_HVT U2909 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[5]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[6]), .Y(n2725) );
  NOR4X1_HVT U2910 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[3]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[4]), .A3(n4234), .A4(n2725), 
        .Y(n4249) );
  OR2X2_LVT U2911 ( .A1(SPI_SCK), .A2(n5531), .Y(n2726) );
  INVX1_HVT U2912 ( .A(n2726), .Y(n2730) );
  NAND2X0_HVT U2913 ( .A1(n4249), .A2(AHB_SPI_WRAPPER_SPI_CONTROLLER_SUBSTATE), 
        .Y(n3480) );
  AND2X1_HVT U2917 ( .A1(n3480), .A2(n4547), .Y(n4222) );
  INVX1_HVT U2918 ( .A(n4222), .Y(n2728) );
  OR2X2_LVT U2921 ( .A1(n2728), .A2(n5112), .Y(n2729) );
  OR2X2_LVT U2922 ( .A1(n2730), .A2(n2729), .Y(n2731) );
  INVX1_HVT U2923 ( .A(n2731), .Y(n2077) );
  AND4X1_HVT U2926 ( .A1(AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_STATE[2]), .A2(AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Counter[0]), .A3(n5011), .A4(n5012), .Y(n2756) );
  INVX1_HVT U2927 ( .A(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Counter[1]), .Y(
        n2788) );
  MUX21X1_HVT U2929 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[0]), .A2(
        AHB_UART_WRAPPER_rx_data[8]), .S0(n2732), .Y(n1839) );
  MUX21X1_HVT U2930 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[6]), .A2(
        AHB_UART_WRAPPER_rx_data[14]), .S0(n2732), .Y(n1833) );
  MUX21X1_HVT U2931 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[2]), .A2(
        AHB_UART_WRAPPER_rx_data[10]), .S0(n2732), .Y(n1837) );
  MUX21X1_HVT U2932 ( .A1(n5402), .A2(AHB_UART_WRAPPER_rx_data[11]), .S0(n2732), .Y(n1836) );
  MUX21X1_HVT U2933 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[1]), .A2(
        AHB_UART_WRAPPER_rx_data[9]), .S0(n2732), .Y(n1838) );
  MUX21X1_HVT U2934 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[7]), .A2(
        AHB_UART_WRAPPER_rx_data[15]), .S0(n2732), .Y(n1832) );
  MUX21X1_HVT U2935 ( .A1(n5406), .A2(AHB_UART_WRAPPER_rx_data[12]), .S0(n2732), .Y(n1835) );
  MUX21X1_HVT U2936 ( .A1(n5391), .A2(AHB_UART_WRAPPER_rx_data[13]), .S0(n2732), .Y(n1834) );
  NAND4X0_HVT U2937 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[2]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[0]), .A3(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[1]), .A4(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[3]), .Y(n2742) );
  INVX1_HVT U2938 ( .A(n2742), .Y(n2734) );
  OR2X2_LVT U2939 ( .A1(n2734), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[4]), .Y(n2733) );
  INVX1_HVT U2940 ( .A(n2733), .Y(n2738) );
  OR2X2_LVT U2942 ( .A1(n5531), .A2(n5121), .Y(n2782) );
  INVX1_HVT U2943 ( .A(n2782), .Y(n4235) );
  INVX1_HVT U2944 ( .A(n4235), .Y(n2736) );
  NAND2X0_HVT U2945 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[4]), .A2(
        n2734), .Y(n2779) );
  INVX1_HVT U2946 ( .A(n2779), .Y(n2735) );
  OR2X2_LVT U2947 ( .A1(n2736), .A2(n2735), .Y(n2737) );
  OR2X2_LVT U2948 ( .A1(n2738), .A2(n2737), .Y(n2739) );
  INVX1_HVT U2949 ( .A(n2739), .Y(n2126) );
  AND3X1_HVT U2950 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[2]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[0]), .A3(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[1]), .Y(n2740) );
  OR2X2_LVT U2951 ( .A1(n2740), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[3]), .Y(n2741) );
  INVX1_HVT U2952 ( .A(n2741), .Y(n2746) );
  INVX1_HVT U2953 ( .A(n4235), .Y(n2744) );
  INVX1_HVT U2954 ( .A(n2742), .Y(n2743) );
  OR2X2_LVT U2955 ( .A1(n2744), .A2(n2743), .Y(n2745) );
  OR2X2_LVT U2956 ( .A1(n2746), .A2(n2745), .Y(n2747) );
  INVX1_HVT U2957 ( .A(n2747), .Y(n2127) );
  INVX1_HVT U2958 ( .A(n2748), .Y(n2750) );
  OR2X2_LVT U2959 ( .A1(n2750), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[6]), .Y(
        n2749) );
  INVX1_HVT U2960 ( .A(n2749), .Y(n2754) );
  NAND2X0_HVT U2961 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[6]), .A2(
        n2750), .Y(n3452) );
  INVX1_HVT U2962 ( .A(n3452), .Y(n2752) );
  OR2X2_LVT U2964 ( .A1(n2752), .A2(n5133), .Y(n2753) );
  OR2X2_LVT U2965 ( .A1(n2754), .A2(n2753), .Y(n2755) );
  INVX1_HVT U2966 ( .A(n2755), .Y(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N22) );
  OR2X2_LVT U2967 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Counter[1]), .A2(
        n2756), .Y(n2757) );
  INVX1_HVT U2968 ( .A(n2757), .Y(n2776) );
  INVX1_HVT U2969 ( .A(AHB_UART_WRAPPER_rx_byte_size[2]), .Y(n2760) );
  OR2X2_LVT U2970 ( .A1(n2760), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Counter[1]), .Y(
        n2758) );
  INVX1_HVT U2971 ( .A(n2758), .Y(n2771) );
  NAND2X0_HVT U2972 ( .A1(AHB_UART_WRAPPER_rx_byte_size[1]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Counter[1]), .Y(
        n2759) );
  AND2X1_HVT U2973 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Counter[0]), .A2(
        n2759), .Y(n2766) );
  INVX1_HVT U2974 ( .A(AHB_UART_WRAPPER_rx_byte_size[1]), .Y(n2761) );
  OR2X2_LVT U2977 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Counter[0]), .A2(
        n5200), .Y(n2764) );
  INVX1_HVT U2978 ( .A(n2764), .Y(n2765) );
  MUX21X1_HVT U2979 ( .A1(n2766), .A2(n2765), .S0(
        AHB_UART_WRAPPER_rx_byte_size[0]), .Y(n2767) );
  INVX1_HVT U2980 ( .A(n2767), .Y(n2769) );
  OR2X2_LVT U2983 ( .A1(n2769), .A2(n5201), .Y(n2770) );
  OR2X2_LVT U2984 ( .A1(n2771), .A2(n2770), .Y(n2772) );
  INVX1_HVT U2985 ( .A(n2772), .Y(n4479) );
  NAND4X0_HVT U2986 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_STATE[2]), .A2(n4479), 
        .A3(n5011), .A4(n5012), .Y(n2778) );
  INVX1_HVT U2987 ( .A(n2778), .Y(n2774) );
  AND3X1_HVT U2988 ( .A1(AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_STATE[2]), .A2(n5011), .A3(n5012), .Y(n4477) );
  OR2X2_LVT U2991 ( .A1(n2774), .A2(n5129), .Y(n2775) );
  OR2X2_LVT U2992 ( .A1(n2776), .A2(n2775), .Y(n2777) );
  INVX1_HVT U2993 ( .A(n2777), .Y(n1868) );
  OAI21X1_HVT U2994 ( .A1(AHB_UART_WRAPPER_rx_valid_clr), .A2(n4737), .A3(
        n2778), .Y(n1848) );
  INVX1_HVT U2995 ( .A(n2779), .Y(n2781) );
  OR2X2_LVT U2996 ( .A1(n2781), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[5]), .Y(n2780) );
  INVX1_HVT U2997 ( .A(n2780), .Y(n2786) );
  NAND2X0_HVT U2998 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[5]), .A2(
        n2781), .Y(n4239) );
  INVX1_HVT U2999 ( .A(n4239), .Y(n2784) );
  NAND2X0_HVT U3000 ( .A1(n4281), .A2(n2782), .Y(n4238) );
  INVX1_HVT U3001 ( .A(n4238), .Y(n2783) );
  OR2X2_LVT U3002 ( .A1(n2784), .A2(n2783), .Y(n2785) );
  OR2X2_LVT U3003 ( .A1(n2786), .A2(n2785), .Y(n2787) );
  INVX1_HVT U3004 ( .A(n2787), .Y(n2125) );
  MUX21X1_HVT U3006 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[0]), .A2(
        AHB_UART_WRAPPER_rx_data[16]), .S0(n2829), .Y(n1831) );
  MUX21X1_HVT U3007 ( .A1(n5391), .A2(AHB_UART_WRAPPER_rx_data[21]), .S0(n5502), .Y(n1826) );
  MUX21X1_HVT U3009 ( .A1(n5402), .A2(AHB_UART_WRAPPER_rx_data[3]), .S0(n2830), 
        .Y(n1844) );
  MUX21X1_HVT U3010 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[3]), .A2(
        AHB_UART_WRAPPER_rx_data[19]), .S0(n2829), .Y(n1828) );
  MUX21X1_HVT U3011 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[1]), .A2(
        AHB_UART_WRAPPER_rx_data[17]), .S0(n2829), .Y(n1830) );
  MUX21X1_HVT U3012 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[4]), .A2(
        AHB_UART_WRAPPER_rx_data[4]), .S0(n2830), .Y(n1843) );
  MUX21X1_HVT U3013 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[2]), .A2(
        AHB_UART_WRAPPER_rx_data[18]), .S0(n5502), .Y(n1829) );
  AND2X1_HVT U3014 ( .A1(n4611), .A2(n4612), .Y(n2808) );
  NAND4X0_HVT U3031 ( .A1(n2796), .A2(n2795), .A3(n2794), .A4(n2793), .Y(n2826) );
  NAND2X0_HVT U3039 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[12]), .Y(n2803) );
  NAND2X0_HVT U3043 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[12]), .Y(n2802) );
  AND2X1_HVT U3049 ( .A1(n4610), .A2(n4613), .Y(n2817) );
  NAND2X0_HVT U3061 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[12]), .Y(n2811) );
  NAND2X0_HVT U3065 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[12]), .Y(n2810) );
  NAND2X0_HVT U3070 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[12]), .Y(n2822) );
  NAND4X0_HVT U3083 ( .A1(n2822), .A2(n2821), .A3(n2820), .A4(n2819), .Y(n2823) );
  MUX21X1_HVT U3089 ( .A1(sram_rdata[12]), .A2(n2828), .S0(n5102), .Y(n2438)
         );
  MUX21X1_HVT U3090 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[6]), .A2(
        AHB_UART_WRAPPER_rx_data[22]), .S0(n5502), .Y(n1825) );
  MUX21X1_HVT U3091 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[6]), .A2(
        AHB_UART_WRAPPER_rx_data[6]), .S0(n2830), .Y(n1841) );
  MUX21X1_HVT U3092 ( .A1(n5406), .A2(AHB_UART_WRAPPER_rx_data[20]), .S0(n5502), .Y(n1827) );
  MUX21X1_HVT U3093 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[0]), .A2(
        AHB_UART_WRAPPER_rx_data[0]), .S0(n2830), .Y(n1847) );
  MUX21X1_HVT U3094 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[2]), .A2(
        AHB_UART_WRAPPER_rx_data[2]), .S0(n2830), .Y(n1845) );
  MUX21X1_HVT U3095 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[1]), .A2(
        AHB_UART_WRAPPER_rx_data[1]), .S0(n2830), .Y(n1846) );
  MUX21X1_HVT U3096 ( .A1(n5391), .A2(AHB_UART_WRAPPER_rx_data[5]), .S0(n2830), 
        .Y(n1842) );
  MUX21X1_HVT U3097 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[7]), .A2(
        AHB_UART_WRAPPER_rx_data[23]), .S0(n5502), .Y(n1824) );
  MUX21X1_HVT U3098 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[7]), .A2(
        AHB_UART_WRAPPER_rx_data[7]), .S0(n2830), .Y(n1840) );
  NAND2X0_HVT U3099 ( .A1(n2815), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[9]), .Y(n2834) );
  NAND2X0_HVT U3101 ( .A1(n2791), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[9]), .Y(n2832) );
  NAND2X0_HVT U3104 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[9]), .Y(n2838) );
  NAND2X0_HVT U3105 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[9]), .Y(n2837) );
  NAND2X0_HVT U3106 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[9]), .Y(n2836) );
  NAND2X0_HVT U3109 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[9]), .Y(n2842) );
  NAND2X0_HVT U3112 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[9]), .Y(n2839) );
  NAND2X0_HVT U3114 ( .A1(n5458), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[9]), .Y(n2846) );
  NAND2X0_HVT U3116 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[9]), .Y(n2844) );
  NAND2X0_HVT U3117 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[9]), .Y(n2843) );
  MUX21X1_HVT U3120 ( .A1(sram_rdata[9]), .A2(n2851), .S0(n5102), .Y(n2441) );
  NAND2X0_HVT U3122 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[15]), .Y(n2855) );
  NAND2X0_HVT U3126 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[15]), .Y(n2853) );
  NAND4X0_HVT U3129 ( .A1(n2855), .A2(n2854), .A3(n2853), .A4(n2852), .Y(n2871) );
  NAND2X0_HVT U3133 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[15]), .Y(n2858) );
  NAND2X0_HVT U3140 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[15]), .Y(n2863) );
  NAND2X0_HVT U3142 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[15]), .Y(n2862) );
  NAND2X0_HVT U3144 ( .A1(n5399), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[15]), .Y(n2861) );
  NAND4X0_HVT U3147 ( .A1(n2863), .A2(n2862), .A3(n2861), .A4(n2860), .Y(n2869) );
  NAND2X0_HVT U3149 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[15]), .Y(n2867) );
  NAND2X0_HVT U3155 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[15]), .Y(n2864) );
  NAND4X0_HVT U3156 ( .A1(n2867), .A2(n2866), .A3(n2865), .A4(n2864), .Y(n2868) );
  MUX21X1_HVT U3159 ( .A1(sram_rdata[15]), .A2(n2872), .S0(n5102), .Y(n2435)
         );
  NAND2X0_HVT U3160 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[7]), .Y(n2876) );
  NAND2X0_HVT U3162 ( .A1(n2791), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[7]), .Y(n2874) );
  NAND2X0_HVT U3163 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[7]), .Y(n2873) );
  NAND4X0_HVT U3164 ( .A1(n2876), .A2(n5147), .A3(n2874), .A4(n2873), .Y(n2892) );
  NAND2X0_HVT U3165 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[7]), .Y(n2880) );
  NAND2X0_HVT U3168 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[7]), .Y(n2877) );
  NAND4X0_HVT U3169 ( .A1(n2880), .A2(n2879), .A3(n2878), .A4(n2877), .Y(n2891) );
  NAND2X0_HVT U3171 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[7]), .Y(n2883) );
  NAND2X0_HVT U3173 ( .A1(n5458), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[7]), .Y(n2881) );
  NAND2X0_HVT U3175 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[7]), .Y(n2888) );
  NAND2X0_HVT U3176 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[7]), .Y(n2887) );
  NAND4X0_HVT U3179 ( .A1(n2888), .A2(n2887), .A3(n2886), .A4(n2885), .Y(n2889) );
  MUX21X1_HVT U3181 ( .A1(sram_rdata[7]), .A2(n2893), .S0(n5102), .Y(n2443) );
  NAND2X0_HVT U3184 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[19]), .Y(n2895) );
  NAND2X0_HVT U3185 ( .A1(n2791), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[19]), .Y(n2894) );
  NAND4X0_HVT U3186 ( .A1(n2897), .A2(n2896), .A3(n2895), .A4(n2894), .Y(n2913) );
  NAND2X0_HVT U3187 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[19]), .Y(n2901) );
  NAND2X0_HVT U3189 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[19]), .Y(n2899) );
  NAND4X0_HVT U3191 ( .A1(n2901), .A2(n2900), .A3(n2899), .A4(n2898), .Y(n2912) );
  NAND2X0_HVT U3192 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[19]), .Y(n2905) );
  NAND2X0_HVT U3194 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[19]), .Y(n2903) );
  NAND2X0_HVT U3195 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[19]), .Y(n2902) );
  NAND4X0_HVT U3196 ( .A1(n2905), .A2(n2904), .A3(n2903), .A4(n2902), .Y(n2911) );
  NAND2X0_HVT U3198 ( .A1(n5458), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[19]), .Y(n2908) );
  NAND2X0_HVT U3199 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[19]), .Y(n2907) );
  NAND2X0_HVT U3200 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[19]), .Y(n2906) );
  NAND4X0_HVT U3201 ( .A1(n2909), .A2(n2908), .A3(n2907), .A4(n2906), .Y(n2910) );
  MUX21X1_HVT U3203 ( .A1(sram_rdata[19]), .A2(n2914), .S0(n5102), .Y(n2431)
         );
  NAND2X0_HVT U3204 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[1]), .Y(n2918) );
  NAND2X0_HVT U3205 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[1]), .Y(n2917) );
  NAND2X0_HVT U3206 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[1]), .Y(n2916) );
  NAND2X0_HVT U3209 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[1]), .Y(n2922) );
  NAND2X0_HVT U3211 ( .A1(n5278), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[1]), .Y(n2920) );
  NAND2X0_HVT U3212 ( .A1(n2814), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[1]), .Y(n2919) );
  NAND2X0_HVT U3215 ( .A1(n5458), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[1]), .Y(n2925) );
  NAND2X0_HVT U3216 ( .A1(n5399), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[1]), .Y(n2924) );
  NAND2X0_HVT U3217 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[1]), .Y(n2923) );
  NAND4X0_HVT U3218 ( .A1(n2926), .A2(n2925), .A3(n2924), .A4(n2923), .Y(n2932) );
  NAND2X0_HVT U3219 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[1]), .Y(n2930) );
  NAND2X0_HVT U3221 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[1]), .Y(n2928) );
  NAND2X0_HVT U3222 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[1]), .Y(n2927) );
  NAND4X0_HVT U3223 ( .A1(n2930), .A2(n2929), .A3(n2928), .A4(n2927), .Y(n2931) );
  MUX21X1_HVT U3225 ( .A1(sram_rdata[1]), .A2(n2935), .S0(n5102), .Y(n2449) );
  NAND2X0_HVT U3228 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[5]), .Y(n2937) );
  NAND2X0_HVT U3229 ( .A1(n5278), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[5]), .Y(n2936) );
  NAND2X0_HVT U3231 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[5]), .Y(n2943) );
  NAND2X0_HVT U3232 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[5]), .Y(n2942) );
  NAND2X0_HVT U3233 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[5]), .Y(n2941) );
  NAND2X0_HVT U3234 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[5]), .Y(n2940) );
  NAND2X0_HVT U3236 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[5]), .Y(n2947) );
  NAND2X0_HVT U3238 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[5]), .Y(n2945) );
  NAND2X0_HVT U3241 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[5]), .Y(n2951) );
  NAND2X0_HVT U3242 ( .A1(n2791), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[5]), .Y(n2950) );
  NAND2X0_HVT U3244 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[5]), .Y(n2948) );
  MUX21X1_HVT U3247 ( .A1(sram_rdata[5]), .A2(n2956), .S0(n5102), .Y(n2445) );
  NAND2X0_HVT U3248 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[25]), .Y(n2960) );
  NAND2X0_HVT U3249 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[25]), .Y(n2959) );
  NAND2X0_HVT U3250 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[25]), .Y(n2958) );
  NAND4X0_HVT U3252 ( .A1(n2960), .A2(n2959), .A3(n2958), .A4(n2957), .Y(n2976) );
  NAND2X0_HVT U3253 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[25]), .Y(n2964) );
  NAND2X0_HVT U3255 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[25]), .Y(n2962) );
  NAND2X0_HVT U3258 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[25]), .Y(n2968) );
  NAND2X0_HVT U3259 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[25]), .Y(n2967) );
  NAND4X0_HVT U3262 ( .A1(n2968), .A2(n2967), .A3(n2966), .A4(n2965), .Y(n2974) );
  NAND2X0_HVT U3263 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[25]), .Y(n2972) );
  NAND2X0_HVT U3264 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[25]), .Y(n2971) );
  NAND2X0_HVT U3266 ( .A1(n2791), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[25]), .Y(n2969) );
  NAND4X0_HVT U3267 ( .A1(n2972), .A2(n2971), .A3(n2970), .A4(n2969), .Y(n2973) );
  MUX21X1_HVT U3269 ( .A1(sram_rdata[25]), .A2(n2977), .S0(n5103), .Y(n2425)
         );
  NAND2X0_HVT U3270 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[11]), .Y(n2981) );
  NAND2X0_HVT U3272 ( .A1(n5399), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[11]), .Y(n2979) );
  NAND2X0_HVT U3273 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[11]), .Y(n2978) );
  NAND4X0_HVT U3274 ( .A1(n2981), .A2(n2980), .A3(n2979), .A4(n2978), .Y(n2997) );
  NAND2X0_HVT U3277 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[11]), .Y(n2983) );
  NAND2X0_HVT U3280 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[11]), .Y(n2989) );
  NAND4X0_HVT U3284 ( .A1(n2989), .A2(n2988), .A3(n2987), .A4(n2986), .Y(n2995) );
  NAND2X0_HVT U3287 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[11]), .Y(n2991) );
  MUX21X1_HVT U3291 ( .A1(sram_rdata[11]), .A2(n2998), .S0(n5102), .Y(n2439)
         );
  NAND2X0_HVT U3293 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[8]), .Y(n3001) );
  NAND2X0_HVT U3295 ( .A1(n2791), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[8]), .Y(n2999) );
  NAND2X0_HVT U3299 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[8]), .Y(n3004) );
  NAND2X0_HVT U3300 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[8]), .Y(n3003) );
  NAND4X0_HVT U3301 ( .A1(n3006), .A2(n3005), .A3(n3004), .A4(n3003), .Y(n3017) );
  NAND2X0_HVT U3302 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[8]), .Y(n3010) );
  NAND2X0_HVT U3303 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[8]), .Y(n3009) );
  NAND2X0_HVT U3304 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[8]), .Y(n3008) );
  NAND2X0_HVT U3309 ( .A1(n5458), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[8]), .Y(n3012) );
  NAND4X0_HVT U3311 ( .A1(n3014), .A2(n3013), .A3(n3012), .A4(n3011), .Y(n3015) );
  MUX21X1_HVT U3313 ( .A1(sram_rdata[8]), .A2(n3019), .S0(n5102), .Y(n2442) );
  NAND2X0_HVT U3314 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[4]), .Y(n3023) );
  NAND2X0_HVT U3317 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[4]), .Y(n3020) );
  NAND2X0_HVT U3320 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[4]), .Y(n3026) );
  NAND2X0_HVT U3321 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[4]), .Y(n3025) );
  NAND2X0_HVT U3322 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[4]), .Y(n3024) );
  NAND4X0_HVT U3323 ( .A1(n3027), .A2(n3026), .A3(n3025), .A4(n3024), .Y(n3038) );
  NAND2X0_HVT U3325 ( .A1(n5458), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[4]), .Y(n3030) );
  NAND4X0_HVT U3328 ( .A1(n3031), .A2(n3030), .A3(n3029), .A4(n3028), .Y(n3037) );
  NAND2X0_HVT U3329 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[4]), .Y(n3035) );
  NAND2X0_HVT U3330 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[4]), .Y(n3034) );
  NAND2X0_HVT U3332 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[4]), .Y(n3032) );
  MUX21X1_HVT U3335 ( .A1(sram_rdata[4]), .A2(n3040), .S0(n5102), .Y(n2446) );
  NAND2X0_HVT U3336 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[20]), .Y(n3044) );
  NAND2X0_HVT U3338 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[20]), .Y(n3042) );
  NAND2X0_HVT U3342 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[20]), .Y(n3047) );
  NAND2X0_HVT U3344 ( .A1(n5274), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[20]), .Y(n3045) );
  NAND4X0_HVT U3345 ( .A1(n3048), .A2(n3047), .A3(n3046), .A4(n3045), .Y(n3059) );
  NAND2X0_HVT U3346 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[20]), .Y(n3052) );
  NAND2X0_HVT U3347 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[20]), .Y(n3051) );
  NAND4X0_HVT U3350 ( .A1(n3052), .A2(n3051), .A3(n3050), .A4(n3049), .Y(n3058) );
  NAND2X0_HVT U3351 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[20]), .Y(n3056) );
  NAND2X0_HVT U3352 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[20]), .Y(n3055) );
  NAND2X0_HVT U3353 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[20]), .Y(n3054) );
  NAND2X0_HVT U3354 ( .A1(n5399), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[20]), .Y(n3053) );
  NAND4X0_HVT U3355 ( .A1(n3056), .A2(n3055), .A3(n3054), .A4(n3053), .Y(n3057) );
  MUX21X1_HVT U3357 ( .A1(sram_rdata[20]), .A2(n3061), .S0(n5103), .Y(n2430)
         );
  NAND2X0_HVT U3360 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[23]), .Y(n3063) );
  NAND2X0_HVT U3361 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[23]), .Y(n3062) );
  NAND4X0_HVT U3362 ( .A1(n3065), .A2(n3064), .A3(n3063), .A4(n3062), .Y(n3081) );
  NAND2X0_HVT U3364 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[23]), .Y(n3068) );
  NAND2X0_HVT U3365 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[23]), .Y(n3067) );
  NAND2X0_HVT U3366 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[23]), .Y(n3066) );
  NAND4X0_HVT U3367 ( .A1(n3069), .A2(n3068), .A3(n3067), .A4(n3066), .Y(n3080) );
  NAND2X0_HVT U3368 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[23]), .Y(n3073) );
  NAND2X0_HVT U3370 ( .A1(n2791), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[23]), .Y(n3071) );
  NAND4X0_HVT U3372 ( .A1(n3073), .A2(n3072), .A3(n3071), .A4(n3070), .Y(n3079) );
  NAND2X0_HVT U3374 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[23]), .Y(n3076) );
  MUX21X1_HVT U3379 ( .A1(sram_rdata[23]), .A2(n3082), .S0(n5103), .Y(n2427)
         );
  NAND2X0_HVT U3380 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[0]), .Y(n3086) );
  NAND2X0_HVT U3382 ( .A1(n2791), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[0]), .Y(n3084) );
  NAND2X0_HVT U3383 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[0]), .Y(n3083) );
  NAND4X0_HVT U3384 ( .A1(n3086), .A2(n3085), .A3(n3084), .A4(n3083), .Y(n3102) );
  NAND2X0_HVT U3386 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[0]), .Y(n3089) );
  NAND2X0_HVT U3388 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[0]), .Y(n3087) );
  NAND2X0_HVT U3395 ( .A1(n5458), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[0]), .Y(n3098) );
  NAND2X0_HVT U3398 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[0]), .Y(n3095) );
  NAND4X0_HVT U3399 ( .A1(n3098), .A2(n5144), .A3(n3096), .A4(n3095), .Y(n3099) );
  MUX21X1_HVT U3401 ( .A1(sram_rdata[0]), .A2(n3103), .S0(n5102), .Y(n2450) );
  NAND2X0_HVT U3402 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[24]), .Y(n3107) );
  NAND2X0_HVT U3403 ( .A1(n5458), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[24]), .Y(n3106) );
  NAND2X0_HVT U3404 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[24]), .Y(n3105) );
  NAND2X0_HVT U3405 ( .A1(n2791), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[24]), .Y(n3104) );
  NAND4X0_HVT U3406 ( .A1(n3107), .A2(n3106), .A3(n3105), .A4(n3104), .Y(n3123) );
  NAND2X0_HVT U3408 ( .A1(n5426), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[24]), .Y(n3110) );
  NAND2X0_HVT U3409 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[24]), .Y(n3109) );
  NAND4X0_HVT U3411 ( .A1(n3111), .A2(n3110), .A3(n3109), .A4(n5143), .Y(n3122) );
  NAND2X0_HVT U3412 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[24]), .Y(n3115) );
  NAND2X0_HVT U3415 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[24]), .Y(n3112) );
  NAND4X0_HVT U3416 ( .A1(n3115), .A2(n3114), .A3(n3113), .A4(n3112), .Y(n3121) );
  NAND2X0_HVT U3417 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[24]), .Y(n3119) );
  NAND2X0_HVT U3419 ( .A1(n5427), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[24]), .Y(n3117) );
  NAND4X0_HVT U3421 ( .A1(n3119), .A2(n3118), .A3(n3117), .A4(n3116), .Y(n3120) );
  MUX21X1_HVT U3423 ( .A1(sram_rdata[24]), .A2(n3124), .S0(n5103), .Y(n2426)
         );
  NAND2X0_HVT U3424 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[17]), .Y(n3128) );
  NAND2X0_HVT U3426 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[17]), .Y(n3126) );
  NAND4X0_HVT U3428 ( .A1(n3128), .A2(n3127), .A3(n3126), .A4(n5142), .Y(n3144) );
  NAND2X0_HVT U3429 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[17]), .Y(n3132) );
  NAND2X0_HVT U3431 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[17]), .Y(n3130) );
  NAND2X0_HVT U3432 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[17]), .Y(n3129) );
  NAND4X0_HVT U3433 ( .A1(n3132), .A2(n3131), .A3(n3130), .A4(n3129), .Y(n3143) );
  NAND2X0_HVT U3435 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[17]), .Y(n3135) );
  NAND2X0_HVT U3436 ( .A1(n2791), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[17]), .Y(n3134) );
  NAND2X0_HVT U3437 ( .A1(n5426), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[17]), .Y(n3133) );
  NAND4X0_HVT U3438 ( .A1(n3136), .A2(n3135), .A3(n3134), .A4(n3133), .Y(n3142) );
  NAND2X0_HVT U3440 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[17]), .Y(n3139) );
  MUX21X1_HVT U3445 ( .A1(sram_rdata[17]), .A2(n3145), .S0(n5103), .Y(n2433)
         );
  NAND2X0_HVT U3446 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[13]), .Y(n3149) );
  NAND2X0_HVT U3451 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[13]), .Y(n3153) );
  NAND2X0_HVT U3453 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[13]), .Y(n3151) );
  NAND4X0_HVT U3455 ( .A1(n3153), .A2(n3152), .A3(n3151), .A4(n3150), .Y(n3164) );
  NAND2X0_HVT U3456 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[13]), .Y(n3157) );
  NAND2X0_HVT U3457 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[13]), .Y(n3156) );
  NAND4X0_HVT U3460 ( .A1(n3157), .A2(n3156), .A3(n3155), .A4(n3154), .Y(n3163) );
  MUX21X1_HVT U3467 ( .A1(sram_rdata[13]), .A2(n3166), .S0(n5102), .Y(n2437)
         );
  NAND4X0_HVT U3472 ( .A1(n3170), .A2(n3169), .A3(n3168), .A4(n3167), .Y(n3186) );
  NAND2X0_HVT U3473 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[2]), .Y(n3174) );
  NAND2X0_HVT U3475 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[2]), .Y(n3172) );
  NAND4X0_HVT U3477 ( .A1(n3174), .A2(n3173), .A3(n3172), .A4(n3171), .Y(n3185) );
  NAND4X0_HVT U3482 ( .A1(n3178), .A2(n3177), .A3(n3176), .A4(n3175), .Y(n3184) );
  NAND2X0_HVT U3483 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[2]), .Y(n3182) );
  NAND2X0_HVT U3484 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[2]), .Y(n3181) );
  NAND2X0_HVT U3486 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[2]), .Y(n3179) );
  OR4X1_HVT U3488 ( .A1(n3186), .A2(n3185), .A3(n3184), .A4(n5252), .Y(n3187)
         );
  MUX21X1_HVT U3489 ( .A1(sram_rdata[2]), .A2(n3187), .S0(n5102), .Y(n2448) );
  NAND2X0_HVT U3490 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[3]), .Y(n3191) );
  NAND2X0_HVT U3491 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[3]), .Y(n3190) );
  NAND2X0_HVT U3492 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[3]), .Y(n3189) );
  NAND2X0_HVT U3495 ( .A1(n2791), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[3]), .Y(n3195) );
  NAND2X0_HVT U3497 ( .A1(n2807), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[3]), .Y(n3193) );
  NAND2X0_HVT U3500 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[3]), .Y(n3199) );
  NAND2X0_HVT U3502 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[3]), .Y(n3197) );
  NAND2X0_HVT U3506 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[3]), .Y(n3202) );
  NAND2X0_HVT U3507 ( .A1(n5458), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[3]), .Y(n3201) );
  NAND4X0_HVT U3509 ( .A1(n3203), .A2(n3202), .A3(n3201), .A4(n5141), .Y(n3204) );
  OR4X1_HVT U3510 ( .A1(n5264), .A2(n5261), .A3(n5259), .A4(n3204), .Y(n3208)
         );
  MUX21X1_HVT U3511 ( .A1(sram_rdata[3]), .A2(n3208), .S0(n5102), .Y(n2447) );
  NAND2X0_HVT U3513 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[22]), .Y(n3211) );
  NAND2X0_HVT U3518 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[22]), .Y(n3215) );
  NAND2X0_HVT U3519 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[22]), .Y(n3214) );
  NAND2X0_HVT U3520 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[22]), .Y(n3213) );
  NAND4X0_HVT U3521 ( .A1(n3216), .A2(n3215), .A3(n3214), .A4(n3213), .Y(n3227) );
  NAND2X0_HVT U3522 ( .A1(n5399), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[22]), .Y(n3220) );
  NAND2X0_HVT U3524 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[22]), .Y(n3218) );
  NAND4X0_HVT U3526 ( .A1(n3220), .A2(n3219), .A3(n3218), .A4(n3217), .Y(n3226) );
  NAND2X0_HVT U3527 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[22]), .Y(n3224) );
  NAND2X0_HVT U3528 ( .A1(n5426), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[22]), .Y(n3223) );
  NAND2X0_HVT U3529 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[22]), .Y(n3222) );
  NAND4X0_HVT U3531 ( .A1(n3224), .A2(n3223), .A3(n3222), .A4(n3221), .Y(n3225) );
  MUX21X1_HVT U3533 ( .A1(sram_rdata[22]), .A2(n3229), .S0(n5103), .Y(n2428)
         );
  NAND2X0_HVT U3534 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[21]), .Y(n3233) );
  NAND2X0_HVT U3535 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[21]), .Y(n3232) );
  NAND2X0_HVT U3536 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[21]), .Y(n3231) );
  NAND2X0_HVT U3537 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[21]), .Y(n3230) );
  NAND4X0_HVT U3538 ( .A1(n3233), .A2(n3232), .A3(n3231), .A4(n3230), .Y(n3249) );
  NAND2X0_HVT U3540 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[21]), .Y(n3236) );
  NAND2X0_HVT U3542 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[21]), .Y(n3234) );
  NAND2X0_HVT U3545 ( .A1(n5399), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[21]), .Y(n3240) );
  NAND2X0_HVT U3546 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[21]), .Y(n3239) );
  NAND2X0_HVT U3547 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[21]), .Y(n3238) );
  NAND4X0_HVT U3548 ( .A1(n3241), .A2(n3240), .A3(n3239), .A4(n3238), .Y(n3247) );
  NAND2X0_HVT U3552 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[21]), .Y(n3242) );
  MUX21X1_HVT U3555 ( .A1(sram_rdata[21]), .A2(n3250), .S0(n5102), .Y(n2429)
         );
  NAND2X0_HVT U3557 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[16]), .Y(n3253) );
  NAND2X0_HVT U3559 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[16]), .Y(n3251) );
  NAND4X0_HVT U3560 ( .A1(n3254), .A2(n3253), .A3(n3252), .A4(n3251), .Y(n3270) );
  NAND2X0_HVT U3562 ( .A1(n5399), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[16]), .Y(n3257) );
  NAND2X0_HVT U3563 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[16]), .Y(n3256) );
  NAND2X0_HVT U3564 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[16]), .Y(n3255) );
  NAND4X0_HVT U3565 ( .A1(n3258), .A2(n3257), .A3(n3256), .A4(n3255), .Y(n3269) );
  NAND2X0_HVT U3567 ( .A1(n5458), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[16]), .Y(n3261) );
  NAND2X0_HVT U3568 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[16]), .Y(n3260) );
  NAND4X0_HVT U3570 ( .A1(n3262), .A2(n3261), .A3(n3260), .A4(n3259), .Y(n3268) );
  NAND2X0_HVT U3573 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[16]), .Y(n3264) );
  NAND4X0_HVT U3575 ( .A1(n3266), .A2(n3265), .A3(n3264), .A4(n3263), .Y(n3267) );
  MUX21X1_HVT U3577 ( .A1(sram_rdata[16]), .A2(n3271), .S0(n5102), .Y(n2434)
         );
  NAND2X0_HVT U3580 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[18]), .Y(n3273) );
  NAND2X0_HVT U3581 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[18]), .Y(n3272) );
  NAND4X0_HVT U3582 ( .A1(n3275), .A2(n3274), .A3(n3273), .A4(n3272), .Y(n3291) );
  NAND2X0_HVT U3585 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[18]), .Y(n3277) );
  NAND2X0_HVT U3586 ( .A1(n2797), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[18]), .Y(n3276) );
  NAND2X0_HVT U3588 ( .A1(n2791), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[18]), .Y(n3283) );
  NAND2X0_HVT U3589 ( .A1(n5458), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[18]), .Y(n3282) );
  NAND2X0_HVT U3590 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[18]), .Y(n3281) );
  NAND2X0_HVT U3591 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[18]), .Y(n3280) );
  NAND4X0_HVT U3592 ( .A1(n3283), .A2(n3282), .A3(n3281), .A4(n3280), .Y(n3289) );
  NAND2X0_HVT U3593 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[18]), .Y(n3287) );
  NAND2X0_HVT U3594 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[18]), .Y(n3286) );
  NAND2X0_HVT U3595 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[18]), .Y(n3285) );
  NAND4X0_HVT U3597 ( .A1(n3287), .A2(n3286), .A3(n3285), .A4(n5140), .Y(n3288) );
  MUX21X1_HVT U3599 ( .A1(sram_rdata[18]), .A2(n3292), .S0(n5103), .Y(n2432)
         );
  NAND2X0_HVT U3600 ( .A1(n2790), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[10]), .Y(n3296) );
  NAND2X0_HVT U3601 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[10]), .Y(n3295) );
  NAND2X0_HVT U3602 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[10]), .Y(n3294) );
  NAND2X0_HVT U3603 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[10]), .Y(n3293) );
  NAND2X0_HVT U3605 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[10]), .Y(n3300) );
  NAND2X0_HVT U3607 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[10]), .Y(n3298) );
  NAND2X0_HVT U3612 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[10]), .Y(n3302) );
  NAND2X0_HVT U3613 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[10]), .Y(n3301) );
  NAND4X0_HVT U3614 ( .A1(n5139), .A2(n3303), .A3(n3302), .A4(n3301), .Y(n3310) );
  NAND2X0_HVT U3615 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[10]), .Y(n3308) );
  NAND4X0_HVT U3619 ( .A1(n3308), .A2(n3307), .A3(n3306), .A4(n3305), .Y(n3309) );
  OR4X1_HVT U3620 ( .A1(n5266), .A2(n5253), .A3(n3310), .A4(n3309), .Y(n3313)
         );
  MUX21X1_HVT U3621 ( .A1(sram_rdata[10]), .A2(n3313), .S0(n5102), .Y(n2440)
         );
  NAND2X0_HVT U3623 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[6]), .Y(n3316) );
  NAND2X0_HVT U3624 ( .A1(n2809), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[6]), .Y(n3315) );
  NAND4X0_HVT U3631 ( .A1(n3321), .A2(n3320), .A3(n3319), .A4(n5157), .Y(n3332) );
  NAND2X0_HVT U3632 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[6]), .Y(n3325) );
  NAND2X0_HVT U3633 ( .A1(n2815), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[6]), .Y(n3324) );
  NAND2X0_HVT U3634 ( .A1(n2790), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[6]), .Y(n3323) );
  NAND2X0_HVT U3635 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[6]), .Y(n3322) );
  NAND2X0_HVT U3639 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[6]), .Y(n3327) );
  NAND4X0_HVT U3641 ( .A1(n3329), .A2(n3328), .A3(n3327), .A4(n5138), .Y(n3330) );
  OR4X1_HVT U3642 ( .A1(n3333), .A2(n3332), .A3(n5257), .A4(n3330), .Y(n3335)
         );
  MUX21X1_HVT U3643 ( .A1(sram_rdata[6]), .A2(n3335), .S0(n5102), .Y(n2444) );
  NAND2X0_HVT U3645 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[26]), .Y(n3338) );
  NAND2X0_HVT U3646 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[26]), .Y(n3337) );
  NAND4X0_HVT U3648 ( .A1(n3339), .A2(n3338), .A3(n3337), .A4(n3336), .Y(n3355) );
  NAND2X0_HVT U3649 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[26]), .Y(n3343) );
  NAND2X0_HVT U3650 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[26]), .Y(n3342) );
  NAND2X0_HVT U3651 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[26]), .Y(n3341) );
  NAND2X0_HVT U3652 ( .A1(n2791), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[26]), .Y(n3340) );
  NAND4X0_HVT U3653 ( .A1(n3343), .A2(n3342), .A3(n3341), .A4(n3340), .Y(n3354) );
  NAND2X0_HVT U3654 ( .A1(n5278), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[26]), .Y(n3347) );
  NAND2X0_HVT U3657 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[26]), .Y(n3344) );
  NAND2X0_HVT U3660 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[26]), .Y(n3350) );
  NAND2X0_HVT U3662 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[26]), .Y(n3348) );
  NAND4X0_HVT U3663 ( .A1(n3351), .A2(n3350), .A3(n3349), .A4(n3348), .Y(n3352) );
  MUX21X1_HVT U3665 ( .A1(sram_rdata[26]), .A2(n3356), .S0(n5103), .Y(n2424)
         );
  NAND2X0_HVT U3666 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[27]), .Y(n3360) );
  NAND2X0_HVT U3667 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[27]), .Y(n3359) );
  NAND2X0_HVT U3668 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[27]), .Y(n3358) );
  NAND2X0_HVT U3671 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[27]), .Y(n3364) );
  NAND2X0_HVT U3672 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[27]), .Y(n3363) );
  NAND2X0_HVT U3673 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[27]), .Y(n3362) );
  NAND2X0_HVT U3674 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[27]), .Y(n3361) );
  NAND4X0_HVT U3675 ( .A1(n3364), .A2(n3363), .A3(n3362), .A4(n3361), .Y(n3375) );
  NAND2X0_HVT U3676 ( .A1(n5278), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[27]), .Y(n3368) );
  NAND2X0_HVT U3682 ( .A1(n2791), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[27]), .Y(n3371) );
  NAND2X0_HVT U3683 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[27]), .Y(n3370) );
  NAND2X0_HVT U3684 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[27]), .Y(n3369) );
  NAND4X0_HVT U3685 ( .A1(n3372), .A2(n3371), .A3(n3370), .A4(n3369), .Y(n3373) );
  MUX21X1_HVT U3687 ( .A1(sram_rdata[27]), .A2(n3377), .S0(n5103), .Y(n2423)
         );
  NAND2X0_HVT U3688 ( .A1(n2791), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[14]), .Y(n3381) );
  NAND2X0_HVT U3690 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[14]), .Y(n3379) );
  NAND4X0_HVT U3692 ( .A1(n3381), .A2(n3380), .A3(n3379), .A4(n3378), .Y(n3397) );
  NAND2X0_HVT U3693 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[14]), .Y(n3385) );
  NAND2X0_HVT U3696 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[14]), .Y(n3382) );
  NAND4X0_HVT U3697 ( .A1(n3385), .A2(n3384), .A3(n3383), .A4(n3382), .Y(n3396) );
  NAND2X0_HVT U3698 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[14]), .Y(n3389) );
  NAND2X0_HVT U3699 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[14]), .Y(n3388) );
  NAND2X0_HVT U3700 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[14]), .Y(n3387) );
  NAND2X0_HVT U3701 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[14]), .Y(n3386) );
  NAND4X0_HVT U3702 ( .A1(n3389), .A2(n3388), .A3(n3387), .A4(n3386), .Y(n3395) );
  NAND2X0_HVT U3706 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[14]), .Y(n3390) );
  MUX21X1_HVT U3709 ( .A1(sram_rdata[14]), .A2(n3399), .S0(n5102), .Y(n2436)
         );
  MUX21X1_HVT U3710 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[2]), .A2(
        AHB_UART_WRAPPER_rx_data[26]), .S0(n5500), .Y(n1821) );
  MUX21X1_HVT U3711 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[0]), .A2(
        AHB_UART_WRAPPER_rx_data[24]), .S0(n5500), .Y(n1823) );
  MUX21X1_HVT U3712 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[7]), .A2(
        AHB_UART_WRAPPER_rx_data[31]), .S0(n5500), .Y(n1816) );
  MUX21X1_HVT U3713 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[6]), .A2(
        AHB_UART_WRAPPER_rx_data[30]), .S0(n5500), .Y(n1817) );
  MUX21X1_HVT U3714 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[1]), .A2(
        AHB_UART_WRAPPER_rx_data[25]), .S0(n5500), .Y(n1822) );
  MUX21X1_HVT U3715 ( .A1(n5406), .A2(AHB_UART_WRAPPER_rx_data[28]), .S0(n3400), .Y(n1819) );
  MUX21X1_HVT U3716 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[5]), .A2(
        AHB_UART_WRAPPER_rx_data[29]), .S0(n3400), .Y(n1818) );
  MUX21X1_HVT U3717 ( .A1(n5402), .A2(AHB_UART_WRAPPER_rx_data[27]), .S0(n5500), .Y(n1820) );
  OR3X1_HVT U3718 ( .A1(AHB_UART_WRAPPER_tx_byte_size[1]), .A2(
        AHB_UART_WRAPPER_tx_byte_size[2]), .A3(
        AHB_UART_WRAPPER_tx_byte_size[0]), .Y(n3408) );
  NAND2X0_HVT U3724 ( .A1(AHB_UART_WRAPPER_tx_byte_size[2]), .A2(n5013), .Y(
        n3410) );
  NAND2X0_HVT U3725 ( .A1(n5507), .A2(AHB_UART_WRAPPER_tx_byte_size[1]), .Y(
        n3402) );
  AND2X1_HVT U3726 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter[0]), .A2(
        n3402), .Y(n3407) );
  INVX1_HVT U3727 ( .A(AHB_UART_WRAPPER_tx_byte_size[1]), .Y(n3757) );
  INVX1_HVT U3728 ( .A(AHB_UART_WRAPPER_tx_byte_size[2]), .Y(n3765) );
  OR2X2_LVT U3731 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter[0]), .A2(
        n5202), .Y(n3405) );
  INVX1_HVT U3732 ( .A(n3405), .Y(n3406) );
  MUX21X1_HVT U3733 ( .A1(n3407), .A2(n3406), .S0(
        AHB_UART_WRAPPER_tx_byte_size[0]), .Y(n3409) );
  NAND4X0_HVT U3735 ( .A1(n5488), .A2(n5111), .A3(n4732), .A4(n4472), .Y(n4470) );
  OAI21X1_HVT U3736 ( .A1(n4732), .A2(n5371), .A3(n4470), .Y(n1869) );
  NAND2X0_HVT U3737 ( .A1(AHB_SPI_WRAPPER_spi_start), .A2(n5121), .Y(n3411) );
  MUX21X1_HVT U3740 ( .A1(AHB_SPI_WRAPPER_tx_data[0]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[0]), .S0(n5135), .Y(n2173) );
  MUX21X1_HVT U3741 ( .A1(AHB_SPI_WRAPPER_tx_data[1]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[1]), .S0(n5135), .Y(n2172) );
  MUX21X1_HVT U3748 ( .A1(AHB_SPI_WRAPPER_tx_data[22]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[22]), .S0(n5136), .Y(n2151) );
  MUX21X1_HVT U3750 ( .A1(AHB_SPI_WRAPPER_tx_data[3]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[3]), .S0(n5135), .Y(n2170) );
  MUX21X1_HVT U3751 ( .A1(AHB_SPI_WRAPPER_tx_data[8]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[8]), .S0(n5136), .Y(n2165) );
  MUX21X1_HVT U3752 ( .A1(AHB_SPI_WRAPPER_tx_data[20]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[20]), .S0(n5136), .Y(n2153) );
  MUX21X1_HVT U3753 ( .A1(AHB_SPI_WRAPPER_tx_byte_size[2]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_size[2]), .S0(n5135), .Y(n2143) );
  MUX21X1_HVT U3754 ( .A1(AHB_SPI_WRAPPER_tx_data[18]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[18]), .S0(n5136), .Y(n2155) );
  MUX21X1_HVT U3755 ( .A1(AHB_SPI_WRAPPER_tx_byte_size[1]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_size[1]), .S0(n5135), .Y(n2144) );
  MUX21X1_HVT U3756 ( .A1(AHB_SPI_WRAPPER_tx_data[19]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[19]), .S0(n5136), .Y(n2154) );
  MUX21X1_HVT U3757 ( .A1(AHB_SPI_WRAPPER_tx_data[7]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[7]), .S0(n5135), .Y(n2166) );
  MUX21X1_HVT U3758 ( .A1(AHB_SPI_WRAPPER_tx_data[16]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[16]), .S0(n5136), .Y(n2157) );
  MUX21X1_HVT U3759 ( .A1(AHB_SPI_WRAPPER_tx_data[4]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[4]), .S0(n5135), .Y(n2169) );
  MUX21X1_HVT U3760 ( .A1(AHB_SPI_WRAPPER_tx_data[11]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[11]), .S0(n5136), .Y(n2162) );
  MUX21X1_HVT U3761 ( .A1(AHB_SPI_WRAPPER_tx_data[15]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[15]), .S0(n5136), .Y(n2158) );
  MUX21X1_HVT U3762 ( .A1(AHB_SPI_WRAPPER_tx_byte_size[0]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_size[0]), .S0(n5135), .Y(n2145) );
  MUX21X1_HVT U3763 ( .A1(AHB_SPI_WRAPPER_rx_byte_size[1]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_size[1]), .S0(n5135), .Y(n2147) );
  MUX21X1_HVT U3764 ( .A1(AHB_SPI_WRAPPER_tx_data[13]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[13]), .S0(n5136), .Y(n2160) );
  MUX21X1_HVT U3765 ( .A1(AHB_SPI_WRAPPER_tx_data[5]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[5]), .S0(n5136), .Y(n2168) );
  MUX21X1_HVT U3766 ( .A1(AHB_SPI_WRAPPER_tx_data[2]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[2]), .S0(n5135), .Y(n2171) );
  MUX21X1_HVT U3767 ( .A1(AHB_SPI_WRAPPER_rx_byte_size[2]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_size[2]), .S0(n5135), .Y(n2146) );
  MUX21X1_HVT U3768 ( .A1(AHB_SPI_WRAPPER_tx_data[14]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[14]), .S0(n5136), .Y(n2159) );
  MUX21X1_HVT U3769 ( .A1(AHB_SPI_WRAPPER_tx_data[9]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[9]), .S0(n5136), .Y(n2164) );
  MUX21X1_HVT U3770 ( .A1(AHB_SPI_WRAPPER_tx_data[6]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[6]), .S0(n5135), .Y(n2167) );
  MUX21X1_HVT U3771 ( .A1(AHB_SPI_WRAPPER_rx_byte_size[0]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_size[0]), .S0(n5135), .Y(n2148) );
  MUX21X1_HVT U3772 ( .A1(AHB_SPI_WRAPPER_tx_data[10]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[10]), .S0(n5136), .Y(n2163) );
  MUX21X1_HVT U3773 ( .A1(AHB_SPI_WRAPPER_tx_data[23]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[23]), .S0(n5136), .Y(n2150) );
  MUX21X1_HVT U3774 ( .A1(AHB_SPI_WRAPPER_tx_data[12]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[12]), .S0(n5136), .Y(n2161) );
  MUX21X1_HVT U3775 ( .A1(AHB_SPI_WRAPPER_tx_data[21]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[21]), .S0(n5136), .Y(n2152) );
  MUX21X1_HVT U3776 ( .A1(AHB_SPI_WRAPPER_tx_data[17]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[17]), .S0(n5136), .Y(n2156) );
  NAND2X0_HVT U3777 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[1]), .A2(n4719), 
        .Y(n3462) );
  NAND2X0_HVT U3781 ( .A1(n5109), .A2(n5017), .Y(n546) );
  INVX1_HVT U3782 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_size[2]), .Y(n3417)
         );
  NAND2X0_HVT U3783 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_size[1]), .A2(
        n4724), .Y(n3416) );
  AND2X1_HVT U3784 ( .A1(n3417), .A2(n3416), .Y(n3418) );
  OR3X1_HVT U3785 ( .A1(n4725), .A2(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_size[0]), 
        .A3(n3418), .Y(n3420) );
  OR2X2_LVT U3786 ( .A1(n5285), .A2(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_size[1]), 
        .Y(n3419) );
  NAND2X0_HVT U3789 ( .A1(n4406), .A2(n5109), .Y(n4397) );
  INVX1_HVT U3790 ( .A(n4397), .Y(n4404) );
  NAND2X0_HVT U3791 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[2]), .A2(n4404), 
        .Y(n4376) );
  NAND3X0_HVT U3794 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[3]), .A2(n5120), 
        .A3(n5017), .Y(n4390) );
  OA22X1_HVT U3795 ( .A1(n5505), .A2(n4376), .A3(n5454), .A4(n4390), .Y(n3428)
         );
  NAND2X2_HVT U3796 ( .A1(n5505), .A2(n4719), .Y(n4372) );
  NAND3X0_HVT U3798 ( .A1(n5120), .A2(n5454), .A3(n5108), .Y(n3427) );
  INVX1_HVT U3799 ( .A(n546), .Y(n3425) );
  MUX41X1_HVT U3800 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[4]), .A3(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[5]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[6]), .A4(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[7]), .S0(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_bit_counter[0]), .S1(n5394), .Y(n3421)
         );
  NAND2X0_HVT U3801 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_bit_counter[2]), .A2(
        n3421), .Y(n3424) );
  MUX41X1_HVT U3802 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[0]), .A3(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[1]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[2]), .A4(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[3]), .S0(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_bit_counter[0]), .S1(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_bit_counter[1]), .Y(n3422) );
  NAND2X0_HVT U3803 ( .A1(n4728), .A2(n3422), .Y(n3423) );
  NAND4X0_HVT U3804 ( .A1(n3425), .A2(n5016), .A3(n3424), .A4(n3423), .Y(n3426) );
  NAND3X0_HVT U3805 ( .A1(n3428), .A2(n3427), .A3(n3426), .Y(n3447) );
  NAND2X0_HVT U3806 ( .A1(n4719), .A2(n5017), .Y(n4374) );
  NAND3X0_HVT U3811 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[0]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[3]), .A3(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[1]), .Y(n3435) );
  AND2X1_HVT U3812 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[4]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[5]), .Y(n3430) );
  INVX1_HVT U3813 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[6]), .Y(
        n3429) );
  NAND4X0_HVT U3815 ( .A1(n3430), .A2(n3429), .A3(n4715), .A4(n5018), .Y(n3431) );
  NOR4X1_HVT U3816 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[7]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[8]), .A3(n3435), .A4(n3431), 
        .Y(n3442) );
  NAND4X0_HVT U3817 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[0]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[6]), .A3(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[7]), .A4(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[8]), .Y(n3432) );
  OR3X1_HVT U3818 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[3]), .A2(
        n4716), .A3(n3432), .Y(n3463) );
  INVX1_HVT U3819 ( .A(n3463), .Y(n3433) );
  AND4X1_HVT U3820 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[1]), .A2(
        n3433), .A3(AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[5]), .A4(n4715), 
        .Y(n4361) );
  NAND2X0_HVT U3823 ( .A1(n5505), .A2(n5454), .Y(n3438) );
  INVX1_HVT U3824 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[5]), .Y(
        n3434) );
  AND2X1_HVT U3825 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[2]), .A2(
        n3434), .Y(n3437) );
  NAND2X0_HVT U3826 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[7]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[8]), .Y(n4353) );
  NOR4X1_HVT U3827 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[6]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[4]), .A3(n4353), .A4(n3435), 
        .Y(n3436) );
  OA221X1_HVT U3828 ( .A1(n3438), .A2(n3437), .A3(n3438), .A4(n3436), .A5(
        n5120), .Y(n3440) );
  AND2X1_HVT U3830 ( .A1(n3442), .A2(n5119), .Y(n3439) );
  OAI22X1_HVT U3831 ( .A1(n3442), .A2(n3441), .A3(n3440), .A4(n3439), .Y(n3443) );
  OA221X1_HVT U3832 ( .A1(n5454), .A2(n4372), .A3(n5454), .A4(n3612), .A5(
        n3443), .Y(n3445) );
  NAND3X0_HVT U3833 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[3]), .A2(n5505), 
        .A3(n5120), .Y(n3464) );
  MUX21X1_HVT U3835 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_SDA_PULLDOWN), .A2(
        n3447), .S0(n3446), .Y(n1949) );
  NAND2X0_HVT U3838 ( .A1(n5435), .A2(n5510), .Y(n3451) );
  NAND2X0_HVT U3840 ( .A1(n5092), .A2(n4744), .Y(n3450) );
  NAND2X0_HVT U3842 ( .A1(n5094), .A2(n5435), .Y(n3449) );
  NAND2X0_HVT U3843 ( .A1(n5092), .A2(n5094), .Y(n3448) );
  OA21X1_HVT U3845 ( .A1(spi_readyout), .A2(n3450), .A3(n4062), .Y(n4063) );
  NAND2X2_HVT U3848 ( .A1(n5170), .A2(n4739), .Y(n4220) );
  MUX21X1_HVT U3849 ( .A1(AHB_SPI_WRAPPER_sl_wstrb[3]), .A2(
        AHB_SPI_WRAPPER_AHB_SPI_SUB_wstrb_reg[3]), .S0(n4220), .Y(n2215) );
  MUX21X1_HVT U3850 ( .A1(AHB_SPI_WRAPPER_sl_wstrb[1]), .A2(
        AHB_SPI_WRAPPER_AHB_SPI_SUB_wstrb_reg[1]), .S0(n4220), .Y(n2219) );
  NAND2X2_HVT U3851 ( .A1(n5170), .A2(n4740), .Y(n4320) );
  MUX21X1_HVT U3852 ( .A1(AHB_I2C_WRAPPER_sl_wstrb[1]), .A2(
        AHB_I2C_WRAPPER_AHB_I2C_SUB_wstrb_reg[1]), .S0(n4320), .Y(n2034) );
  NAND2X4_HVT U3853 ( .A1(n5170), .A2(n4662), .Y(n4204) );
  MUX21X1_HVT U3854 ( .A1(AHB_SRAM_WRAPPER_sl_wstrb[2]), .A2(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_wstrb_reg[2]), .S0(n4204), .Y(n2369) );
  MUX21X1_HVT U3855 ( .A1(AHB_SPI_WRAPPER_sl_wstrb[2]), .A2(
        AHB_SPI_WRAPPER_AHB_SPI_SUB_wstrb_reg[2]), .S0(n4220), .Y(n2217) );
  MUX21X1_HVT U3856 ( .A1(AHB_I2C_WRAPPER_sl_wstrb[3]), .A2(
        AHB_I2C_WRAPPER_AHB_I2C_SUB_wstrb_reg[3]), .S0(n4320), .Y(n2030) );
  MUX21X1_HVT U3857 ( .A1(AHB_I2C_WRAPPER_sl_wstrb[2]), .A2(
        AHB_I2C_WRAPPER_AHB_I2C_SUB_wstrb_reg[2]), .S0(n4320), .Y(n2032) );
  MUX21X1_HVT U3858 ( .A1(AHB_I2C_WRAPPER_sl_wstrb[0]), .A2(
        AHB_I2C_WRAPPER_AHB_I2C_SUB_wstrb_reg[0]), .S0(n4320), .Y(n2036) );
  MUX21X1_HVT U3859 ( .A1(AHB_SRAM_WRAPPER_sl_wstrb[1]), .A2(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_wstrb_reg[1]), .S0(n4204), .Y(n2371) );
  MUX21X1_HVT U3860 ( .A1(AHB_SRAM_WRAPPER_sl_wstrb[0]), .A2(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_wstrb_reg[0]), .S0(n4204), .Y(n2373) );
  MUX21X1_HVT U3861 ( .A1(AHB_SRAM_WRAPPER_sl_wstrb[3]), .A2(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_wstrb_reg[3]), .S0(n4204), .Y(n2367) );
  MUX21X1_HVT U3862 ( .A1(AHB_SPI_WRAPPER_sl_wstrb[0]), .A2(
        AHB_SPI_WRAPPER_AHB_SPI_SUB_wstrb_reg[0]), .S0(n4220), .Y(n2221) );
  INVX1_HVT U3863 ( .A(n3452), .Y(n3709) );
  NAND2X0_HVT U3864 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[7]), .A2(
        n3709), .Y(n3708) );
  INVX1_HVT U3865 ( .A(n3708), .Y(n3454) );
  OR2X2_LVT U3866 ( .A1(n3454), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[8]), .Y(
        n3453) );
  INVX1_HVT U3867 ( .A(n3453), .Y(n3458) );
  NAND2X0_HVT U3868 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[8]), .A2(
        n3454), .Y(n3711) );
  INVX1_HVT U3869 ( .A(n3711), .Y(n3456) );
  OR2X2_LVT U3871 ( .A1(n3456), .A2(n5133), .Y(n3457) );
  OR2X2_LVT U3872 ( .A1(n3458), .A2(n3457), .Y(n3459) );
  INVX1_HVT U3873 ( .A(n3459), .Y(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N24) );
  NAND2X4_HVT U3874 ( .A1(n4663), .A2(n5170), .Y(n4528) );
  MUX21X1_HVT U3875 ( .A1(AHB_UART_WRAPPER_sl_wstrb[0]), .A2(
        AHB_UART_WRAPPER_AHB_UART_SUB_wstrb_reg[0]), .S0(n4528), .Y(n2309) );
  MUX21X1_HVT U3876 ( .A1(AHB_UART_WRAPPER_sl_wstrb[3]), .A2(
        AHB_UART_WRAPPER_AHB_UART_SUB_wstrb_reg[3]), .S0(n4528), .Y(n2303) );
  MUX21X1_HVT U3877 ( .A1(AHB_UART_WRAPPER_sl_wstrb[2]), .A2(
        AHB_UART_WRAPPER_AHB_UART_SUB_wstrb_reg[2]), .S0(n4528), .Y(n2305) );
  MUX21X1_HVT U3878 ( .A1(AHB_UART_WRAPPER_sl_wstrb[1]), .A2(
        AHB_UART_WRAPPER_AHB_UART_SUB_wstrb_reg[1]), .S0(n4528), .Y(n2307) );
  NAND3X0_HVT U3879 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[2]), .A2(n5119), 
        .A3(n5381), .Y(n3518) );
  AND2X1_HVT U3880 ( .A1(n4398), .A2(n3518), .Y(n4331) );
  NAND2X0_HVT U3882 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[0]), .A2(
        n5168), .Y(n4346) );
  INVX1_HVT U3883 ( .A(n4346), .Y(n3460) );
  OR2X2_LVT U3884 ( .A1(n3460), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[1]), .Y(n3461) );
  INVX1_HVT U3885 ( .A(n3461), .Y(n3469) );
  NAND2X0_HVT U3887 ( .A1(n4360), .A2(n4359), .Y(n4345) );
  NOR4X1_HVT U3888 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[5]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[1]), .A3(n3463), .A4(n4715), 
        .Y(n3509) );
  OA22X1_HVT U3889 ( .A1(n4361), .A2(n4345), .A3(n3509), .A4(n3464), .Y(n3465)
         );
  NAND3X0_HVT U3892 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[0]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[1]), .A3(n5168), .Y(n4349)
         );
  INVX1_HVT U3893 ( .A(n4349), .Y(n3466) );
  OR2X2_LVT U3894 ( .A1(n5193), .A2(n3466), .Y(n3468) );
  OR2X2_LVT U3895 ( .A1(n3469), .A2(n3468), .Y(n3470) );
  INVX1_HVT U3896 ( .A(n3470), .Y(n1947) );
  INVX1_HVT U3897 ( .A(n4349), .Y(n4350) );
  AND2X1_HVT U3898 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[2]), .A2(
        n4350), .Y(n3472) );
  OR2X2_LVT U3899 ( .A1(n3472), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[3]), .Y(n3471) );
  INVX1_HVT U3900 ( .A(n3471), .Y(n3476) );
  NAND2X0_HVT U3902 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[3]), .A2(
        n3472), .Y(n4351) );
  INVX1_HVT U3903 ( .A(n4351), .Y(n3473) );
  OR2X2_LVT U3904 ( .A1(n5193), .A2(n3473), .Y(n3475) );
  OR2X2_LVT U3905 ( .A1(n3476), .A2(n3475), .Y(n3477) );
  INVX1_HVT U3906 ( .A(n3477), .Y(n1945) );
  MUX21X1_HVT U3908 ( .A1(AHB_I2C_WRAPPER_AHB_I2C_SUB_addr_reg[0]), .A2(
        AHB_I2C_WRAPPER_sl_addr[0]), .S0(n5196), .Y(n2024) );
  MUX21X1_HVT U3909 ( .A1(AHB_I2C_WRAPPER_AHB_I2C_SUB_addr_reg[1]), .A2(
        AHB_I2C_WRAPPER_sl_addr[1]), .S0(n5196), .Y(n2023) );
  MUX21X1_HVT U3910 ( .A1(AHB_I2C_WRAPPER_AHB_I2C_SUB_write_reg), .A2(
        AHB_I2C_WRAPPER_sl_write), .S0(n5196), .Y(n2025) );
  MUX21X1_HVT U3912 ( .A1(AHB_SPI_WRAPPER_AHB_SPI_SUB_addr_reg[0]), .A2(
        AHB_SPI_WRAPPER_sl_addr[0]), .S0(n5197), .Y(n2209) );
  MUX21X1_HVT U3913 ( .A1(AHB_SPI_WRAPPER_AHB_SPI_SUB_write_reg), .A2(
        AHB_SPI_WRAPPER_sl_write), .S0(n5197), .Y(n2210) );
  MUX21X1_HVT U3914 ( .A1(n5309), .A2(AHB_SPI_WRAPPER_sl_addr[1]), .S0(n5197), 
        .Y(n2208) );
  MUX21X1_HVT U3916 ( .A1(AHB_UART_WRAPPER_AHB_UART_SUB_addr_reg[0]), .A2(
        AHB_UART_WRAPPER_sl_addr[0]), .S0(n5194), .Y(n2297) );
  MUX21X1_HVT U3917 ( .A1(AHB_UART_WRAPPER_AHB_UART_SUB_addr_reg[1]), .A2(
        AHB_UART_WRAPPER_sl_addr[1]), .S0(n5194), .Y(n2296) );
  AND2X1_HVT U3918 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_STATE[0]), .A2(n4708), 
        .Y(n3502) );
  OA221X1_HVT U3919 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter[0]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[17]), .A3(n4709), .A4(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[9]), .A5(n3502), .Y(n3479) );
  OA222X1_HVT U3920 ( .A1(n5031), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter[1]), .A3(n5031), .A4(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[1]), .A5(
        AHB_SPI_WRAPPER_tx_data[25]), .A6(n5459), .Y(n3478) );
  OR2X2_LVT U3921 ( .A1(n3479), .A2(n3478), .Y(n3486) );
  AND3X1_HVT U3922 ( .A1(n4711), .A2(n4710), .A3(n4707), .Y(n4305) );
  INVX1_HVT U3923 ( .A(n3480), .Y(n4301) );
  NAND4X0_HVT U3924 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_STATE[0]), .A2(n4305), 
        .A3(n4301), .A4(n5030), .Y(n3688) );
  INVX1_HVT U3925 ( .A(n3688), .Y(n4277) );
  INVX1_HVT U3926 ( .A(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_size[1]), .Y(n3483)
         );
  INVX1_HVT U3927 ( .A(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_size[2]), .Y(n3482)
         );
  OA222X1_HVT U3928 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter[1]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_size[1]), .A3(n4708), .A4(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_size[2]), .A5(n3483), .A6(n3482), 
        .Y(n3481) );
  NAND2X0_HVT U3929 ( .A1(n3481), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter[0]), .Y(n3485) );
  OA221X1_HVT U3930 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_size[1]), .A2(
        n4708), .A3(n3483), .A4(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter[1]), 
        .A5(n3482), .Y(n3484) );
  NAND3X0_HVT U3931 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_size[0]), .A2(
        n3484), .A3(n4709), .Y(n4276) );
  OA21X1_HVT U3932 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_size[0]), .A2(n3485), .A3(n4276), .Y(n3689) );
  OA21X1_HVT U3933 ( .A1(n4709), .A2(n4708), .A3(n3689), .Y(n4302) );
  NAND2X0_HVT U3934 ( .A1(n4277), .A2(n4302), .Y(n4274) );
  MUX21X1_HVT U3936 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte[1]), .A2(
        n3486), .S0(n3505), .Y(n2137) );
  OA221X1_HVT U3937 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter[0]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[16]), .A3(n4709), .A4(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[8]), .A5(n3502), .Y(n3488) );
  OA222X1_HVT U3938 ( .A1(n5031), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter[1]), .A3(n5031), .A4(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[0]), .A5(
        AHB_SPI_WRAPPER_tx_data[24]), .A6(n5459), .Y(n3487) );
  OR2X2_LVT U3939 ( .A1(n3488), .A2(n3487), .Y(n3489) );
  MUX21X1_HVT U3940 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte[0]), .A2(
        n3489), .S0(n3505), .Y(n2138) );
  OA221X1_HVT U3941 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter[0]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[22]), .A3(n4709), .A4(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[14]), .A5(n3502), .Y(n3491) );
  OA222X1_HVT U3942 ( .A1(n5031), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter[1]), .A3(n5031), .A4(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[6]), .A5(
        AHB_SPI_WRAPPER_tx_data[30]), .A6(n5459), .Y(n3490) );
  OR2X2_LVT U3943 ( .A1(n3491), .A2(n3490), .Y(n3492) );
  MUX21X1_HVT U3944 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte[6]), .A2(
        n3492), .S0(n3505), .Y(n2132) );
  OA221X1_HVT U3945 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter[0]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[18]), .A3(n4709), .A4(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[10]), .A5(n3502), .Y(n3494) );
  OA222X1_HVT U3946 ( .A1(n5031), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter[1]), .A3(n5031), .A4(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[2]), .A5(
        AHB_SPI_WRAPPER_tx_data[26]), .A6(n5459), .Y(n3493) );
  OR2X2_LVT U3947 ( .A1(n3494), .A2(n3493), .Y(n3495) );
  MUX21X1_HVT U3948 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte[2]), .A2(
        n3495), .S0(n3505), .Y(n2136) );
  OA221X1_HVT U3949 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter[0]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[19]), .A3(n4709), .A4(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[11]), .A5(n3502), .Y(n3497) );
  OA222X1_HVT U3950 ( .A1(n5031), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter[1]), .A3(n5031), .A4(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[3]), .A5(
        AHB_SPI_WRAPPER_tx_data[27]), .A6(n5459), .Y(n3496) );
  OR2X2_LVT U3951 ( .A1(n3497), .A2(n3496), .Y(n3498) );
  MUX21X1_HVT U3952 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte[3]), .A2(
        n3498), .S0(n3505), .Y(n2135) );
  OA221X1_HVT U3953 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter[0]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[21]), .A3(n4709), .A4(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[13]), .A5(n3502), .Y(n3500) );
  OA222X1_HVT U3954 ( .A1(n5031), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter[1]), .A3(n5031), .A4(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[5]), .A5(
        AHB_SPI_WRAPPER_tx_data[29]), .A6(n5459), .Y(n3499) );
  OR2X2_LVT U3955 ( .A1(n3500), .A2(n3499), .Y(n3501) );
  MUX21X1_HVT U3956 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte[5]), .A2(
        n3501), .S0(n3505), .Y(n2133) );
  OA221X1_HVT U3957 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter[0]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[20]), .A3(n4709), .A4(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[12]), .A5(n3502), .Y(n3504) );
  OA222X1_HVT U3958 ( .A1(n5031), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter[1]), .A3(n5031), .A4(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[4]), .A5(
        AHB_SPI_WRAPPER_tx_data[28]), .A6(n5459), .Y(n3503) );
  OR2X2_LVT U3959 ( .A1(n3504), .A2(n3503), .Y(n3506) );
  MUX21X1_HVT U3960 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte[4]), .A2(
        n3506), .S0(n3505), .Y(n2134) );
  MUX21X1_HVT U3962 ( .A1(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[3]), .A2(
        n5038), .S0(n5195), .Y(n2358) );
  MUX21X1_HVT U3963 ( .A1(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[4]), .A2(
        n5037), .S0(n5195), .Y(n2357) );
  MUX21X1_HVT U3964 ( .A1(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[2]), .A2(
        AHB_SRAM_WRAPPER_sl_addr[2]), .S0(n5503), .Y(n2359) );
  MUX21X1_HVT U3965 ( .A1(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[5]), .A2(
        n5035), .S0(n5195), .Y(n2356) );
  MUX21X1_HVT U3966 ( .A1(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[10]), .A2(
        AHB_SRAM_WRAPPER_sl_addr[10]), .S0(n5195), .Y(n2351) );
  MUX21X1_HVT U3967 ( .A1(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[6]), .A2(
        n5033), .S0(n5195), .Y(n2355) );
  MUX21X1_HVT U3968 ( .A1(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_write_reg), .A2(n5046), 
        .S0(n5503), .Y(n2362) );
  MUX21X1_HVT U3969 ( .A1(n5423), .A2(n5032), .S0(n5503), .Y(n2354) );
  MUX21X1_HVT U3970 ( .A1(n5438), .A2(AHB_SRAM_WRAPPER_sl_addr[8]), .S0(n5503), 
        .Y(n2353) );
  MUX21X1_HVT U3971 ( .A1(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[11]), .A2(
        AHB_SRAM_WRAPPER_sl_addr[11]), .S0(n5195), .Y(n2350) );
  MUX21X1_HVT U3972 ( .A1(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[1]), .A2(
        AHB_SRAM_WRAPPER_sl_addr[1]), .S0(n5503), .Y(n2360) );
  MUX21X1_HVT U3973 ( .A1(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[0]), .A2(
        AHB_SRAM_WRAPPER_sl_addr[0]), .S0(n5503), .Y(n2361) );
  MUX21X1_HVT U3974 ( .A1(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[9]), .A2(
        AHB_SRAM_WRAPPER_sl_addr[9]), .S0(n5195), .Y(n2352) );
  MUX21X1_HVT U3981 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_27), .A2(
        AHB_I2C_WRAPPER_tx_data[27]), .S0(n5176), .Y(n1962) );
  MUX21X1_HVT U3982 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_size[1]), .A2(
        AHB_I2C_WRAPPER_rx_byte_size[1]), .S0(n5174), .Y(n1956) );
  MUX21X1_HVT U3983 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_size[0]), .A2(
        AHB_I2C_WRAPPER_rx_byte_size[0]), .S0(n5174), .Y(n1957) );
  MUX21X1_HVT U3984 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_30), .A2(
        AHB_I2C_WRAPPER_tx_data[30]), .S0(n5172), .Y(n1959) );
  MUX21X1_HVT U3985 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_31), .A2(
        AHB_I2C_WRAPPER_tx_data[31]), .S0(n5172), .Y(n1958) );
  MUX21X1_HVT U3986 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rw_mode), .A2(
        AHB_I2C_WRAPPER_tx_data[24]), .S0(n5178), .Y(n1954) );
  OAI21X1_HVT U3988 ( .A1(n5172), .A2(n4720), .A3(n5131), .Y(n1931) );
  INVX1_HVT U3989 ( .A(n4351), .Y(n4352) );
  AND2X1_HVT U3990 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[4]), .A2(
        n4352), .Y(n3510) );
  OR2X2_LVT U3991 ( .A1(n3510), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[5]), .Y(n3511) );
  INVX1_HVT U3992 ( .A(n3511), .Y(n3515) );
  NAND3X0_HVT U3994 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[4]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[5]), .A3(n4352), .Y(n3526)
         );
  INVX1_HVT U3995 ( .A(n3526), .Y(n3512) );
  OR2X2_LVT U3996 ( .A1(n5193), .A2(n3512), .Y(n3514) );
  OR2X2_LVT U3997 ( .A1(n3515), .A2(n3514), .Y(n3516) );
  INVX1_HVT U3998 ( .A(n3516), .Y(n1943) );
  MUX21X1_HVT U4001 ( .A1(n5379), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[15]), .S0(n5175), .Y(n1973) );
  MUX21X1_HVT U4002 ( .A1(AHB_I2C_WRAPPER_tx_data[16]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[16]), .S0(n5175), .Y(n1972) );
  MUX21X1_HVT U4003 ( .A1(AHB_I2C_WRAPPER_tx_data[17]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[17]), .S0(n5175), .Y(n1971) );
  MUX21X1_HVT U4004 ( .A1(AHB_I2C_WRAPPER_tx_data[14]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[14]), .S0(n5171), .Y(n1974) );
  MUX21X1_HVT U4005 ( .A1(n5284), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[19]), .S0(n5175), .Y(n1969) );
  MUX21X1_HVT U4006 ( .A1(n5335), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[23]), .S0(n5175), .Y(n1965) );
  MUX21X1_HVT U4007 ( .A1(n5311), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_25), .S0(n5175), .Y(n1964) );
  MUX21X1_HVT U4008 ( .A1(AHB_I2C_WRAPPER_tx_data[21]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[21]), .S0(n5175), .Y(n1967) );
  MUX21X1_HVT U4009 ( .A1(n5389), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[22]), .S0(n5175), .Y(n1966) );
  MUX21X1_HVT U4010 ( .A1(AHB_I2C_WRAPPER_tx_data[18]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[18]), .S0(n5175), .Y(n1970) );
  MUX21X1_HVT U4011 ( .A1(n5409), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[20]), .S0(n5175), .Y(n1968) );
  MUX21X1_HVT U4013 ( .A1(AHB_I2C_WRAPPER_tx_data[10]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[10]), .S0(n5175), .Y(n1978) );
  MUX21X1_HVT U4014 ( .A1(AHB_I2C_WRAPPER_tx_data[7]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[7]), .S0(n5175), .Y(n1981) );
  MUX21X1_HVT U4015 ( .A1(AHB_I2C_WRAPPER_tx_data[0]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[0]), .S0(n5173), .Y(n1988) );
  MUX21X1_HVT U4016 ( .A1(AHB_I2C_WRAPPER_tx_data[12]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[12]), .S0(n5173), .Y(n1976) );
  MUX21X1_HVT U4017 ( .A1(n5393), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[13]), .S0(n5173), .Y(n1975) );
  MUX21X1_HVT U4018 ( .A1(AHB_I2C_WRAPPER_tx_data[9]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[9]), .S0(n5175), .Y(n1979) );
  MUX21X1_HVT U4019 ( .A1(AHB_I2C_WRAPPER_tx_data[3]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[3]), .S0(n5173), .Y(n1985) );
  MUX21X1_HVT U4020 ( .A1(AHB_I2C_WRAPPER_tx_data[5]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[5]), .S0(n5173), .Y(n1983) );
  MUX21X1_HVT U4021 ( .A1(AHB_I2C_WRAPPER_tx_data[4]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[4]), .S0(n5173), .Y(n1984) );
  MUX21X1_HVT U4022 ( .A1(AHB_I2C_WRAPPER_tx_data[8]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[8]), .S0(n5175), .Y(n1980) );
  MUX21X1_HVT U4023 ( .A1(AHB_I2C_WRAPPER_tx_data[2]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[2]), .S0(n5173), .Y(n1986) );
  MUX21X1_HVT U4024 ( .A1(AHB_I2C_WRAPPER_tx_data[1]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[1]), .S0(n5173), .Y(n1987) );
  MUX21X1_HVT U4025 ( .A1(AHB_I2C_WRAPPER_tx_data[6]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[6]), .S0(n5173), .Y(n1982) );
  MUX21X1_HVT U4026 ( .A1(n5337), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[11]), .S0(n5173), .Y(n1977) );
  INVX1_HVT U4027 ( .A(n3518), .Y(n3525) );
  INVX1_HVT U4029 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_counter[0]), .Y(n4411) );
  INVX1_HVT U4030 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_counter[1]), .Y(n4410) );
  MUX21X1_HVT U4037 ( .A1(n5117), .A2(n5116), .S0(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_size[0]), .Y(n3520) );
  OA222X1_HVT U4039 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_size[1]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_size[0]), .A3(n5340), .A4(n5118), 
        .A5(n3520), .A6(n5019), .Y(n3522) );
  NOR4X1_HVT U4040 ( .A1(n4410), .A2(n4411), .A3(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_size[0]), .A4(n5340), .Y(n3521) );
  INVX1_HVT U4042 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_N310), .Y(n4384) );
  MUX21X1_HVT U4048 ( .A1(n3525), .A2(AHB_I2C_WRAPPER_I2C_CONTROLLER_N310), 
        .S0(n3539), .Y(n1928) );
  INVX1_HVT U4049 ( .A(n3526), .Y(n3528) );
  OR2X2_LVT U4050 ( .A1(n3528), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[6]), .Y(n3527) );
  INVX1_HVT U4051 ( .A(n3527), .Y(n3532) );
  NAND2X0_HVT U4053 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[6]), .A2(
        n3528), .Y(n4354) );
  INVX1_HVT U4054 ( .A(n4354), .Y(n3529) );
  OR2X2_LVT U4055 ( .A1(n5193), .A2(n3529), .Y(n3531) );
  OR2X2_LVT U4056 ( .A1(n3532), .A2(n3531), .Y(n3533) );
  INVX1_HVT U4057 ( .A(n3533), .Y(n1942) );
  INVX1_HVT U4058 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_27), .Y(n3538)
         );
  NAND3X0_HVT U4059 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[2]), .A2(n5381), 
        .A3(n4384), .Y(n4365) );
  INVX1_HVT U4063 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[19]), .Y(n3534)
         );
  OA222X1_HVT U4064 ( .A1(n3575), .A2(n5027), .A3(n3573), .A4(n5023), .A5(
        n4412), .A6(n3534), .Y(n3537) );
  OAI222X1_HVT U4066 ( .A1(n3538), .A2(n4389), .A3(n5179), .A4(n3537), .A5(
        n5506), .A6(n4918), .Y(n3540) );
  MUX21X1_HVT U4068 ( .A1(n3540), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[3]), .S0(n5198), .Y(n1922) );
  INVX1_HVT U4069 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_25), .Y(n3545)
         );
  INVX1_HVT U4071 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[9]), .Y(n3542)
         );
  INVX1_HVT U4072 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[17]), .Y(n3541)
         );
  OA222X1_HVT U4073 ( .A1(n3575), .A2(n5029), .A3(n3573), .A4(n3542), .A5(
        n4412), .A6(n3541), .Y(n3544) );
  OAI222X1_HVT U4075 ( .A1(n3545), .A2(n4389), .A3(n5179), .A4(n3544), .A5(
        n5506), .A6(n4920), .Y(n3546) );
  MUX21X1_HVT U4076 ( .A1(n3546), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[1]), .S0(n5198), .Y(n1924) );
  INVX1_HVT U4079 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[20]), .Y(n3547)
         );
  OA222X1_HVT U4080 ( .A1(n3575), .A2(n5026), .A3(n3573), .A4(n5022), .A5(
        n4412), .A6(n3547), .Y(n3550) );
  OA22X1_HVT U4081 ( .A1(n3550), .A2(n5179), .A3(n4389), .A4(n4722), .Y(n3551)
         );
  NAND2X0_HVT U4083 ( .A1(n3551), .A2(n4323), .Y(n3552) );
  MUX21X1_HVT U4084 ( .A1(n3552), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[4]), .S0(n5198), .Y(n1921) );
  INVX1_HVT U4087 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[21]), .Y(n3553)
         );
  OA222X1_HVT U4088 ( .A1(n3575), .A2(n5025), .A3(n3573), .A4(n5021), .A5(
        n4412), .A6(n3553), .Y(n3556) );
  OA22X1_HVT U4089 ( .A1(n3556), .A2(n5179), .A3(n4389), .A4(n4723), .Y(n3557)
         );
  NAND2X0_HVT U4091 ( .A1(n3557), .A2(n4324), .Y(n3558) );
  INVX1_HVT U4093 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_31), .Y(n3563)
         );
  INVX1_HVT U4094 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[7]), .Y(n3561)
         );
  INVX1_HVT U4095 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[15]), .Y(n3560)
         );
  INVX1_HVT U4096 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[23]), .Y(n3559)
         );
  OA222X1_HVT U4097 ( .A1(n3575), .A2(n3561), .A3(n3573), .A4(n3560), .A5(
        n4412), .A6(n3559), .Y(n3562) );
  OAI222X1_HVT U4099 ( .A1(n3563), .A2(n4389), .A3(n5179), .A4(n3562), .A5(
        n5506), .A6(n4916), .Y(n3564) );
  MUX21X1_HVT U4100 ( .A1(n3564), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[7]), .S0(n5198), .Y(n1918) );
  INVX1_HVT U4102 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[10]), .Y(n3566)
         );
  INVX1_HVT U4103 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[18]), .Y(n3565)
         );
  OA222X1_HVT U4104 ( .A1(n3575), .A2(n5028), .A3(n3573), .A4(n3566), .A5(
        n4412), .A6(n3565), .Y(n3568) );
  OA22X1_HVT U4105 ( .A1(n3568), .A2(n5179), .A3(n4389), .A4(n4721), .Y(n3569)
         );
  NAND2X0_HVT U4107 ( .A1(n3569), .A2(n4322), .Y(n3570) );
  MUX21X1_HVT U4108 ( .A1(n3570), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[2]), .S0(n5198), .Y(n1923) );
  INVX1_HVT U4109 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_30), .Y(n3577)
         );
  INVX1_HVT U4111 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[14]), .Y(n3572)
         );
  INVX1_HVT U4112 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[22]), .Y(n3571)
         );
  OA222X1_HVT U4113 ( .A1(n3575), .A2(n5024), .A3(n3573), .A4(n3572), .A5(
        n4412), .A6(n3571), .Y(n3576) );
  OAI222X1_HVT U4115 ( .A1(n3577), .A2(n4389), .A3(n5179), .A4(n3576), .A5(
        n5506), .A6(n4917), .Y(n3578) );
  MUX21X1_HVT U4116 ( .A1(n3578), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[6]), .S0(n5198), .Y(n1919) );
  MUX21X1_HVT U4120 ( .A1(HADDR[6]), .A2(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[6]), .S0(n5189), .Y(n2412) );
  MUX21X1_HVT U4121 ( .A1(n4863), .A2(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[7]), .S0(n5188), .Y(n2411) );
  MUX21X1_HVT U4122 ( .A1(n4862), .A2(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[4]), .S0(n5189), .Y(n2414) );
  MUX21X1_HVT U4123 ( .A1(HADDR[5]), .A2(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[5]), .S0(n5189), .Y(n2413) );
  MUX21X1_HVT U4124 ( .A1(n4866), .A2(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[10]), .S0(n5188), .Y(n2408) );
  MUX21X1_HVT U4125 ( .A1(n4865), .A2(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[9]), .S0(n5188), .Y(n2409) );
  MUX21X1_HVT U4126 ( .A1(n4864), .A2(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[8]), .S0(n5188), .Y(n2410) );
  MUX21X1_HVT U4127 ( .A1(n4867), .A2(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[11]), .S0(n5188), .Y(n2407) );
  MUX21X1_HVT U4131 ( .A1(AHB_I2C_WRAPPER_AHB_I2C_SUB_addr_reg[2]), .A2(n4860), 
        .S0(n5187), .Y(n2071) );
  MUX21X1_HVT U4132 ( .A1(AHB_I2C_WRAPPER_sl_wdata[3]), .A2(n4828), .S0(n5186), 
        .Y(n2066) );
  MUX21X1_HVT U4137 ( .A1(AHB_UART_WRAPPER_AHB_UART_SUB_wstrb_reg[3]), .A2(
        n4824), .S0(n5185), .Y(n2304) );
  MUX21X1_HVT U4138 ( .A1(AHB_I2C_WRAPPER_AHB_I2C_SUB_addr_reg[3]), .A2(n4861), 
        .S0(n5187), .Y(n2070) );
  MUX21X1_HVT U4141 ( .A1(AHB_I2C_WRAPPER_AHB_I2C_SUB_addr_reg[0]), .A2(n4857), 
        .S0(n5187), .Y(n2073) );
  MUX21X1_HVT U4142 ( .A1(AHB_I2C_WRAPPER_AHB_I2C_SUB_addr_reg[1]), .A2(n4859), 
        .S0(n5187), .Y(n2072) );
  MUX21X1_HVT U4143 ( .A1(AHB_I2C_WRAPPER_sl_wdata[6]), .A2(n4831), .S0(n5186), 
        .Y(n2063) );
  MUX21X1_HVT U4144 ( .A1(AHB_I2C_WRAPPER_sl_wdata[8]), .A2(n4833), .S0(n5186), 
        .Y(n2061) );
  MUX21X1_HVT U4146 ( .A1(AHB_I2C_WRAPPER_sl_wdata[11]), .A2(n4836), .S0(n5186), .Y(n2058) );
  MUX21X1_HVT U4147 ( .A1(AHB_I2C_WRAPPER_sl_wdata[20]), .A2(n4845), .S0(n5186), .Y(n2049) );
  MUX21X1_HVT U4148 ( .A1(AHB_I2C_WRAPPER_sl_wdata[2]), .A2(n4827), .S0(n5186), 
        .Y(n2067) );
  MUX21X1_HVT U4149 ( .A1(AHB_I2C_WRAPPER_sl_wdata[10]), .A2(n4835), .S0(n5186), .Y(n2059) );
  MUX21X1_HVT U4150 ( .A1(AHB_I2C_WRAPPER_sl_wdata[13]), .A2(n4838), .S0(n5186), .Y(n2056) );
  MUX21X1_HVT U4151 ( .A1(AHB_I2C_WRAPPER_sl_wdata[9]), .A2(n4834), .S0(n5186), 
        .Y(n2060) );
  MUX21X1_HVT U4152 ( .A1(AHB_I2C_WRAPPER_sl_wdata[5]), .A2(n4830), .S0(n5186), 
        .Y(n2064) );
  MUX21X1_HVT U4153 ( .A1(n5365), .A2(n4829), .S0(n5186), .Y(n2065) );
  MUX21X1_HVT U4154 ( .A1(AHB_I2C_WRAPPER_sl_wdata[15]), .A2(n4840), .S0(n5186), .Y(n2054) );
  MUX21X1_HVT U4155 ( .A1(AHB_I2C_WRAPPER_sl_wdata[16]), .A2(n4841), .S0(n5186), .Y(n2053) );
  MUX21X1_HVT U4156 ( .A1(AHB_I2C_WRAPPER_sl_wdata[7]), .A2(n4832), .S0(n5186), 
        .Y(n2062) );
  MUX21X1_HVT U4157 ( .A1(AHB_I2C_WRAPPER_sl_wdata[17]), .A2(n4842), .S0(n5186), .Y(n2052) );
  MUX21X1_HVT U4158 ( .A1(AHB_I2C_WRAPPER_sl_wdata[18]), .A2(n4843), .S0(n5186), .Y(n2051) );
  MUX21X1_HVT U4159 ( .A1(AHB_I2C_WRAPPER_sl_wdata[0]), .A2(n4825), .S0(n5186), 
        .Y(n2069) );
  MUX21X1_HVT U4160 ( .A1(AHB_I2C_WRAPPER_sl_wdata[12]), .A2(n4837), .S0(n5186), .Y(n2057) );
  MUX21X1_HVT U4161 ( .A1(AHB_I2C_WRAPPER_sl_wdata[19]), .A2(n4844), .S0(n5186), .Y(n2050) );
  MUX21X1_HVT U4165 ( .A1(AHB_SPI_WRAPPER_AHB_SPI_SUB_wstrb_reg[3]), .A2(n4824), .S0(n5182), .Y(n2216) );
  MUX21X1_HVT U4166 ( .A1(AHB_I2C_WRAPPER_sl_wdata[1]), .A2(n4826), .S0(n5186), 
        .Y(n2068) );
  MUX21X1_HVT U4167 ( .A1(AHB_I2C_WRAPPER_sl_wdata[14]), .A2(n4839), .S0(n5186), .Y(n2055) );
  MUX21X1_HVT U4170 ( .A1(AHB_UART_WRAPPER_sl_wdata[12]), .A2(n4837), .S0(
        n5183), .Y(n2330) );
  MUX21X1_HVT U4171 ( .A1(AHB_SPI_WRAPPER_AHB_SPI_SUB_wstrb_reg[2]), .A2(n4823), .S0(n5182), .Y(n2218) );
  MUX21X1_HVT U4172 ( .A1(AHB_SPI_WRAPPER_AHB_SPI_SUB_wstrb_reg[1]), .A2(n4822), .S0(n5182), .Y(n2220) );
  MUX21X1_HVT U4173 ( .A1(AHB_I2C_WRAPPER_sl_wdata[21]), .A2(n4846), .S0(n5186), .Y(n2048) );
  MUX21X1_HVT U4174 ( .A1(AHB_I2C_WRAPPER_sl_wdata[22]), .A2(n4847), .S0(n5186), .Y(n2047) );
  MUX21X1_HVT U4175 ( .A1(AHB_SPI_WRAPPER_AHB_SPI_SUB_wstrb_reg[0]), .A2(n4821), .S0(n5182), .Y(n2222) );
  MUX21X1_HVT U4176 ( .A1(AHB_SPI_WRAPPER_sl_wdata[31]), .A2(n4856), .S0(n5182), .Y(n2223) );
  MUX21X1_HVT U4177 ( .A1(AHB_I2C_WRAPPER_sl_wdata[23]), .A2(n4848), .S0(n5186), .Y(n2046) );
  MUX21X1_HVT U4178 ( .A1(AHB_I2C_WRAPPER_sl_wdata[24]), .A2(n4849), .S0(n5186), .Y(n2045) );
  MUX21X1_HVT U4179 ( .A1(AHB_SPI_WRAPPER_sl_wdata[30]), .A2(n4855), .S0(n5182), .Y(n2224) );
  MUX21X1_HVT U4180 ( .A1(AHB_I2C_WRAPPER_sl_wdata[25]), .A2(n4850), .S0(n5186), .Y(n2044) );
  MUX21X1_HVT U4181 ( .A1(AHB_SPI_WRAPPER_sl_wdata[29]), .A2(n4854), .S0(n5182), .Y(n2225) );
  MUX21X1_HVT U4182 ( .A1(AHB_SPI_WRAPPER_sl_wdata[28]), .A2(n4853), .S0(n5182), .Y(n2226) );
  MUX21X1_HVT U4183 ( .A1(AHB_SPI_WRAPPER_sl_wdata[27]), .A2(n4852), .S0(n5181), .Y(n2227) );
  MUX21X1_HVT U4184 ( .A1(AHB_I2C_WRAPPER_sl_wdata[26]), .A2(n4851), .S0(n5186), .Y(n2043) );
  MUX21X1_HVT U4185 ( .A1(AHB_SPI_WRAPPER_sl_wdata[26]), .A2(n4851), .S0(n5181), .Y(n2228) );
  MUX21X1_HVT U4186 ( .A1(AHB_I2C_WRAPPER_sl_wdata[27]), .A2(n4852), .S0(n5186), .Y(n2042) );
  MUX21X1_HVT U4187 ( .A1(AHB_I2C_WRAPPER_sl_wdata[28]), .A2(n4853), .S0(n5187), .Y(n2041) );
  MUX21X1_HVT U4188 ( .A1(AHB_I2C_WRAPPER_sl_wdata[29]), .A2(n4854), .S0(n5187), .Y(n2040) );
  MUX21X1_HVT U4189 ( .A1(AHB_SPI_WRAPPER_sl_wdata[25]), .A2(n4850), .S0(n5181), .Y(n2229) );
  MUX21X1_HVT U4190 ( .A1(AHB_SPI_WRAPPER_sl_wdata[24]), .A2(n4849), .S0(n5181), .Y(n2230) );
  MUX21X1_HVT U4193 ( .A1(AHB_SPI_WRAPPER_sl_wdata[23]), .A2(n4848), .S0(n5181), .Y(n2231) );
  MUX21X1_HVT U4194 ( .A1(AHB_SPI_WRAPPER_sl_wdata[22]), .A2(n4847), .S0(n5181), .Y(n2232) );
  MUX21X1_HVT U4195 ( .A1(AHB_SPI_WRAPPER_sl_wdata[21]), .A2(n4846), .S0(n5181), .Y(n2233) );
  MUX21X1_HVT U4196 ( .A1(AHB_I2C_WRAPPER_sl_wdata[30]), .A2(n4855), .S0(n5187), .Y(n2039) );
  MUX21X1_HVT U4197 ( .A1(AHB_SPI_WRAPPER_sl_wdata[20]), .A2(n4845), .S0(n5181), .Y(n2234) );
  MUX21X1_HVT U4198 ( .A1(AHB_SPI_WRAPPER_sl_wdata[19]), .A2(n4844), .S0(n5181), .Y(n2235) );
  MUX21X1_HVT U4199 ( .A1(AHB_SPI_WRAPPER_sl_wdata[18]), .A2(n4843), .S0(n5181), .Y(n2236) );
  MUX21X1_HVT U4200 ( .A1(AHB_SPI_WRAPPER_sl_wdata[17]), .A2(n4842), .S0(n5181), .Y(n2237) );
  MUX21X1_HVT U4201 ( .A1(AHB_I2C_WRAPPER_sl_wdata[31]), .A2(n4856), .S0(n5187), .Y(n2038) );
  MUX21X1_HVT U4202 ( .A1(AHB_I2C_WRAPPER_AHB_I2C_SUB_wstrb_reg[0]), .A2(n4821), .S0(n5187), .Y(n2037) );
  MUX21X1_HVT U4203 ( .A1(AHB_SPI_WRAPPER_sl_wdata[16]), .A2(n4841), .S0(n5181), .Y(n2238) );
  MUX21X1_HVT U4204 ( .A1(AHB_I2C_WRAPPER_AHB_I2C_SUB_wstrb_reg[1]), .A2(n4822), .S0(n5187), .Y(n2035) );
  MUX21X1_HVT U4205 ( .A1(AHB_SPI_WRAPPER_sl_wdata[15]), .A2(n4840), .S0(n5181), .Y(n2239) );
  MUX21X1_HVT U4207 ( .A1(AHB_UART_WRAPPER_AHB_UART_SUB_addr_reg[1]), .A2(
        n4859), .S0(n5185), .Y(n2345) );
  MUX21X1_HVT U4208 ( .A1(AHB_I2C_WRAPPER_AHB_I2C_SUB_wstrb_reg[2]), .A2(n4823), .S0(n5187), .Y(n2033) );
  MUX21X1_HVT U4209 ( .A1(AHB_UART_WRAPPER_AHB_UART_SUB_addr_reg[2]), .A2(
        n4860), .S0(n5185), .Y(n2344) );
  MUX21X1_HVT U4210 ( .A1(AHB_SPI_WRAPPER_sl_wdata[14]), .A2(n4839), .S0(n5181), .Y(n2240) );
  MUX21X1_HVT U4211 ( .A1(AHB_UART_WRAPPER_AHB_UART_SUB_addr_reg[3]), .A2(
        n4861), .S0(n5185), .Y(n2343) );
  MUX21X1_HVT U4212 ( .A1(AHB_UART_WRAPPER_sl_wdata[0]), .A2(n4825), .S0(n5183), .Y(n2342) );
  MUX21X1_HVT U4213 ( .A1(AHB_SPI_WRAPPER_sl_wdata[13]), .A2(n4838), .S0(n5181), .Y(n2241) );
  MUX21X1_HVT U4214 ( .A1(n5350), .A2(n4826), .S0(n5183), .Y(n2341) );
  MUX21X1_HVT U4215 ( .A1(n5418), .A2(n4827), .S0(n5183), .Y(n2340) );
  MUX21X1_HVT U4216 ( .A1(AHB_SPI_WRAPPER_sl_wdata[12]), .A2(n4837), .S0(n5181), .Y(n2242) );
  MUX21X1_HVT U4217 ( .A1(AHB_UART_WRAPPER_sl_wdata[3]), .A2(n4828), .S0(n5183), .Y(n2339) );
  MUX21X1_HVT U4218 ( .A1(n5325), .A2(n4829), .S0(n5183), .Y(n2338) );
  MUX21X1_HVT U4219 ( .A1(AHB_SPI_WRAPPER_sl_wdata[11]), .A2(n4836), .S0(n5181), .Y(n2243) );
  MUX21X1_HVT U4220 ( .A1(AHB_UART_WRAPPER_sl_wdata[5]), .A2(n4830), .S0(n5183), .Y(n2337) );
  MUX21X1_HVT U4221 ( .A1(AHB_UART_WRAPPER_sl_wdata[6]), .A2(n4831), .S0(n5183), .Y(n2336) );
  MUX21X1_HVT U4223 ( .A1(AHB_SPI_WRAPPER_sl_wdata[10]), .A2(n4835), .S0(n5181), .Y(n2244) );
  MUX21X1_HVT U4224 ( .A1(AHB_UART_WRAPPER_sl_wdata[7]), .A2(n4832), .S0(n5183), .Y(n2335) );
  MUX21X1_HVT U4225 ( .A1(AHB_SPI_WRAPPER_sl_wdata[9]), .A2(n4834), .S0(n5181), 
        .Y(n2245) );
  MUX21X1_HVT U4226 ( .A1(AHB_UART_WRAPPER_sl_wdata[8]), .A2(n4833), .S0(n5183), .Y(n2334) );
  MUX21X1_HVT U4227 ( .A1(n5413), .A2(n4833), .S0(n5181), .Y(n2246) );
  MUX21X1_HVT U4228 ( .A1(AHB_UART_WRAPPER_sl_wdata[9]), .A2(n4834), .S0(n5183), .Y(n2333) );
  MUX21X1_HVT U4229 ( .A1(AHB_UART_WRAPPER_sl_wdata[10]), .A2(n4835), .S0(
        n5183), .Y(n2332) );
  MUX21X1_HVT U4230 ( .A1(n5403), .A2(n4832), .S0(n5181), .Y(n2247) );
  MUX21X1_HVT U4231 ( .A1(AHB_UART_WRAPPER_sl_wdata[11]), .A2(n4836), .S0(
        n5183), .Y(n2331) );
  MUX21X1_HVT U4232 ( .A1(n5472), .A2(n4831), .S0(n5181), .Y(n2248) );
  MUX21X1_HVT U4233 ( .A1(n5407), .A2(n4830), .S0(n5181), .Y(n2249) );
  MUX21X1_HVT U4234 ( .A1(AHB_UART_WRAPPER_sl_wdata[13]), .A2(n4838), .S0(
        n5183), .Y(n2329) );
  MUX21X1_HVT U4235 ( .A1(AHB_UART_WRAPPER_sl_wdata[14]), .A2(n4839), .S0(
        n5183), .Y(n2328) );
  MUX21X1_HVT U4236 ( .A1(n5469), .A2(n4829), .S0(n5181), .Y(n2250) );
  MUX21X1_HVT U4237 ( .A1(AHB_UART_WRAPPER_sl_wdata[15]), .A2(n4840), .S0(
        n5183), .Y(n2327) );
  MUX21X1_HVT U4238 ( .A1(n5401), .A2(n4828), .S0(n5181), .Y(n2251) );
  MUX21X1_HVT U4239 ( .A1(AHB_UART_WRAPPER_sl_wdata[16]), .A2(n4841), .S0(
        n5183), .Y(n2326) );
  MUX21X1_HVT U4240 ( .A1(n5465), .A2(n4827), .S0(n5181), .Y(n2252) );
  MUX21X1_HVT U4241 ( .A1(AHB_UART_WRAPPER_sl_wdata[17]), .A2(n4842), .S0(
        n5183), .Y(n2325) );
  MUX21X1_HVT U4242 ( .A1(AHB_I2C_WRAPPER_AHB_I2C_SUB_wstrb_reg[3]), .A2(n4824), .S0(n5187), .Y(n2031) );
  MUX21X1_HVT U4243 ( .A1(AHB_UART_WRAPPER_sl_wdata[18]), .A2(n4843), .S0(
        n5183), .Y(n2324) );
  MUX21X1_HVT U4244 ( .A1(AHB_UART_WRAPPER_sl_wdata[19]), .A2(n4844), .S0(
        n5183), .Y(n2323) );
  MUX21X1_HVT U4245 ( .A1(AHB_SPI_WRAPPER_sl_wdata[1]), .A2(n4826), .S0(n5181), 
        .Y(n2253) );
  MUX21X1_HVT U4246 ( .A1(AHB_UART_WRAPPER_sl_wdata[20]), .A2(n4845), .S0(
        n5183), .Y(n2322) );
  MUX21X1_HVT U4247 ( .A1(n5462), .A2(n4825), .S0(n5181), .Y(n2254) );
  MUX21X1_HVT U4248 ( .A1(AHB_UART_WRAPPER_sl_wdata[21]), .A2(n4846), .S0(
        n5183), .Y(n2321) );
  MUX21X1_HVT U4249 ( .A1(AHB_UART_WRAPPER_sl_wdata[22]), .A2(n4847), .S0(
        n5183), .Y(n2320) );
  MUX21X1_HVT U4250 ( .A1(AHB_SPI_WRAPPER_AHB_SPI_SUB_addr_reg[3]), .A2(n4861), 
        .S0(n5182), .Y(n2255) );
  MUX21X1_HVT U4251 ( .A1(AHB_UART_WRAPPER_sl_wdata[23]), .A2(n4848), .S0(
        n5183), .Y(n2319) );
  MUX21X1_HVT U4252 ( .A1(AHB_SPI_WRAPPER_AHB_SPI_SUB_addr_reg[2]), .A2(n4860), 
        .S0(n5182), .Y(n2256) );
  MUX21X1_HVT U4253 ( .A1(AHB_UART_WRAPPER_sl_wdata[24]), .A2(n4849), .S0(
        n5183), .Y(n2318) );
  MUX21X1_HVT U4254 ( .A1(AHB_UART_WRAPPER_sl_wdata[25]), .A2(n4850), .S0(
        n5183), .Y(n2317) );
  MUX21X1_HVT U4255 ( .A1(AHB_UART_WRAPPER_sl_wdata[26]), .A2(n4851), .S0(
        n5183), .Y(n2316) );
  MUX21X1_HVT U4256 ( .A1(AHB_SPI_WRAPPER_AHB_SPI_SUB_addr_reg[1]), .A2(n4859), 
        .S0(n5182), .Y(n2257) );
  MUX21X1_HVT U4257 ( .A1(AHB_UART_WRAPPER_sl_wdata[27]), .A2(n4852), .S0(
        n5183), .Y(n2315) );
  MUX21X1_HVT U4258 ( .A1(AHB_SPI_WRAPPER_AHB_SPI_SUB_addr_reg[0]), .A2(n4857), 
        .S0(n5182), .Y(n2258) );
  MUX21X1_HVT U4259 ( .A1(AHB_UART_WRAPPER_sl_wdata[28]), .A2(n4853), .S0(
        n5183), .Y(n2314) );
  MUX21X1_HVT U4260 ( .A1(AHB_UART_WRAPPER_sl_wdata[29]), .A2(n4854), .S0(
        n5183), .Y(n2313) );
  MUX21X1_HVT U4261 ( .A1(AHB_UART_WRAPPER_sl_wdata[30]), .A2(n4855), .S0(
        n5183), .Y(n2312) );
  MUX21X1_HVT U4262 ( .A1(AHB_UART_WRAPPER_sl_wdata[31]), .A2(n4856), .S0(
        n5183), .Y(n2311) );
  MUX21X1_HVT U4263 ( .A1(AHB_UART_WRAPPER_AHB_UART_SUB_wstrb_reg[0]), .A2(
        n4821), .S0(n5185), .Y(n2310) );
  MUX21X1_HVT U4264 ( .A1(AHB_UART_WRAPPER_AHB_UART_SUB_wstrb_reg[1]), .A2(
        n4822), .S0(n5185), .Y(n2308) );
  MUX21X1_HVT U4265 ( .A1(AHB_UART_WRAPPER_AHB_UART_SUB_wstrb_reg[2]), .A2(
        n4823), .S0(n5185), .Y(n2306) );
  MUX21X1_HVT U4266 ( .A1(n4859), .A2(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[1]), .S0(n5190), .Y(n2417) );
  MUX21X1_HVT U4269 ( .A1(n4830), .A2(n5085), .S0(n5188), .Y(n2401) );
  MUX21X1_HVT U4270 ( .A1(n4831), .A2(n5083), .S0(n5188), .Y(n2400) );
  MUX21X1_HVT U4271 ( .A1(n4832), .A2(AHB_SRAM_WRAPPER_sl_wdata[7]), .S0(n5188), .Y(n2399) );
  MUX21X1_HVT U4272 ( .A1(n4857), .A2(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[0]), .S0(n5190), .Y(n2418) );
  MUX21X1_HVT U4273 ( .A1(n4834), .A2(n5078), .S0(n5188), .Y(n2397) );
  MUX21X1_HVT U4274 ( .A1(n4835), .A2(n5076), .S0(n5188), .Y(n2396) );
  MUX21X1_HVT U4275 ( .A1(n4836), .A2(n5075), .S0(n5188), .Y(n2395) );
  MUX21X1_HVT U4276 ( .A1(n4827), .A2(n5088), .S0(n5188), .Y(n2404) );
  MUX21X1_HVT U4277 ( .A1(n4837), .A2(n5073), .S0(n5188), .Y(n2394) );
  MUX21X1_HVT U4278 ( .A1(n4860), .A2(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[2]), .S0(n5190), .Y(n2416) );
  MUX21X1_HVT U4279 ( .A1(n4861), .A2(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[3]), .S0(n5190), .Y(n2415) );
  MUX21X1_HVT U4281 ( .A1(n4824), .A2(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_wstrb_reg[3]), .S0(n5190), .Y(n2368) );
  MUX21X1_HVT U4282 ( .A1(n4823), .A2(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_wstrb_reg[2]), .S0(n5190), .Y(n2370) );
  MUX21X1_HVT U4284 ( .A1(n4842), .A2(n5063), .S0(n5188), .Y(n2389) );
  MUX21X1_HVT U4285 ( .A1(n4825), .A2(n5090), .S0(n5188), .Y(n2406) );
  MUX21X1_HVT U4286 ( .A1(n4826), .A2(n5089), .S0(n5188), .Y(n2405) );
  MUX21X1_HVT U4287 ( .A1(n4853), .A2(n5051), .S0(n5190), .Y(n2378) );
  MUX21X1_HVT U4288 ( .A1(n4822), .A2(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_wstrb_reg[1]), .S0(n5190), .Y(n2372) );
  MUX21X1_HVT U4289 ( .A1(n4844), .A2(n5060), .S0(n5188), .Y(n2387) );
  MUX21X1_HVT U4290 ( .A1(n4828), .A2(n5087), .S0(n5188), .Y(n2403) );
  MUX21X1_HVT U4291 ( .A1(n4845), .A2(AHB_SRAM_WRAPPER_sl_wdata[20]), .S0(
        n5188), .Y(n2386) );
  MUX21X1_HVT U4292 ( .A1(n4829), .A2(n5086), .S0(n5188), .Y(n2402) );
  MUX21X1_HVT U4293 ( .A1(n4821), .A2(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_wstrb_reg[0]), .S0(n5190), .Y(n2374) );
  MUX21X1_HVT U4294 ( .A1(n4856), .A2(n5048), .S0(n5190), .Y(n2375) );
  MUX21X1_HVT U4295 ( .A1(n4855), .A2(n5049), .S0(n5190), .Y(n2376) );
  MUX21X1_HVT U4296 ( .A1(n4850), .A2(AHB_SRAM_WRAPPER_sl_wdata[25]), .S0(
        n5188), .Y(n2381) );
  MUX21X1_HVT U4297 ( .A1(n4851), .A2(n5053), .S0(n5188), .Y(n2380) );
  MUX21X1_HVT U4298 ( .A1(n4846), .A2(AHB_SRAM_WRAPPER_sl_wdata[21]), .S0(
        n5188), .Y(n2385) );
  MUX21X1_HVT U4299 ( .A1(n4833), .A2(n5080), .S0(n5188), .Y(n2398) );
  MUX21X1_HVT U4300 ( .A1(n4838), .A2(n5071), .S0(n5188), .Y(n2393) );
  MUX21X1_HVT U4301 ( .A1(n4839), .A2(n5069), .S0(n5188), .Y(n2392) );
  MUX21X1_HVT U4302 ( .A1(n4852), .A2(n5052), .S0(n5188), .Y(n2379) );
  MUX21X1_HVT U4303 ( .A1(n4841), .A2(n5065), .S0(n5188), .Y(n2390) );
  MUX21X1_HVT U4304 ( .A1(n4854), .A2(n5050), .S0(n5190), .Y(n2377) );
  MUX21X1_HVT U4305 ( .A1(n4843), .A2(n5062), .S0(n5188), .Y(n2388) );
  MUX21X1_HVT U4306 ( .A1(n4848), .A2(AHB_SRAM_WRAPPER_sl_wdata[23]), .S0(
        n5188), .Y(n2383) );
  MUX21X1_HVT U4307 ( .A1(n4840), .A2(n5067), .S0(n5188), .Y(n2391) );
  MUX21X1_HVT U4308 ( .A1(n4847), .A2(AHB_SRAM_WRAPPER_sl_wdata[22]), .S0(
        n5188), .Y(n2384) );
  MUX21X1_HVT U4309 ( .A1(n4849), .A2(AHB_SRAM_WRAPPER_sl_wdata[24]), .S0(
        n5188), .Y(n2382) );
  MUX21X1_HVT U4310 ( .A1(AHB_UART_WRAPPER_AHB_UART_SUB_write_reg), .A2(n4819), 
        .S0(n5185), .Y(n2299) );
  MUX21X1_HVT U4311 ( .A1(AHB_SPI_WRAPPER_AHB_SPI_SUB_write_reg), .A2(n4819), 
        .S0(n5182), .Y(n2211) );
  MUX21X1_HVT U4312 ( .A1(AHB_I2C_WRAPPER_AHB_I2C_SUB_write_reg), .A2(n4819), 
        .S0(n5187), .Y(n2026) );
  MUX21X1_HVT U4313 ( .A1(n4819), .A2(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_write_reg), 
        .S0(n5190), .Y(n2363) );
  MUX21X1_HVT U4314 ( .A1(AHB_I2C_WRAPPER_AHB_I2C_SUB_trans_reg_1_), .A2(n4818), .S0(n5187), .Y(n2029) );
  MUX21X1_HVT U4315 ( .A1(AHB_UART_WRAPPER_AHB_UART_SUB_trans_reg_1_), .A2(
        n4818), .S0(n5185), .Y(n2302) );
  MUX21X1_HVT U4316 ( .A1(AHB_SPI_WRAPPER_AHB_SPI_SUB_trans_reg_1_), .A2(n4818), .S0(n5182), .Y(n2214) );
  MUX21X1_HVT U4317 ( .A1(n4818), .A2(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_trans_reg_1_), .S0(n5190), .Y(n2366) );
  AND3X1_HVT U4318 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter[0]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter[1]), .A3(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter[2]), .Y(
        n4521) );
  NAND4X0_HVT U4319 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_STATE[1]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_Rxclk_en), .A3(n4521), .A4(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter[3]), .Y(
        n3599) );
  NOR3X0_HVT U4320 ( .A1(AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_STATE[0]), .A2(AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_STATE[2]), .A3(n3599), .Y(
        n4500) );
  NAND4X0_HVT U4321 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[2]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[0]), .A3(
        n4500), .A4(n4734), .Y(n3600) );
  MUX21X1_HVT U4322 ( .A1(n4816), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[5]), .S0(n3600), .Y(n1861) );
  NAND4X0_HVT U4323 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[2]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[1]), .A3(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[0]), .A4(
        n4500), .Y(n3601) );
  MUX21X1_HVT U4324 ( .A1(n4816), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[7]), .S0(n3601), .Y(n1859) );
  NAND4X0_HVT U4325 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[0]), .A2(
        n4500), .A3(n4733), .A4(n4734), .Y(n3602) );
  MUX21X1_HVT U4326 ( .A1(n4816), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[1]), .S0(n3602), .Y(n1865) );
  NAND4X0_HVT U4327 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[1]), .A2(
        n4500), .A3(n4733), .A4(n4735), .Y(n3603) );
  MUX21X1_HVT U4328 ( .A1(n4816), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[2]), .S0(n3603), .Y(n1864) );
  NAND4X0_HVT U4329 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[1]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[2]), .A3(
        n4500), .A4(n4735), .Y(n3604) );
  MUX21X1_HVT U4330 ( .A1(n4816), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[6]), .S0(n3604), .Y(n1860) );
  NAND4X0_HVT U4331 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[1]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[0]), .A3(
        n4500), .A4(n4733), .Y(n3605) );
  MUX21X1_HVT U4332 ( .A1(n4816), .A2(n5402), .S0(n3605), .Y(n1863) );
  NAND2X2_HVT U4333 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_STATE[1]), .A2(n5031), 
        .Y(n4223) );
  AND3X1_HVT U4335 ( .A1(n5115), .A2(n5535), .A3(n5487), .Y(n4264) );
  NAND2X0_HVT U4337 ( .A1(n3606), .A2(n5136), .Y(n3607) );
  MUX21X1_HVT U4338 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte[0]), .A2(
        n4264), .S0(n3607), .Y(n2123) );
  AND2X1_HVT U4340 ( .A1(n5136), .A2(n4226), .Y(n4260) );
  NAND4X0_HVT U4343 ( .A1(n5115), .A2(n5126), .A3(n5430), .A4(n4710), .Y(n3609) );
  NAND2X0_HVT U4344 ( .A1(n4260), .A2(n3609), .Y(n3610) );
  MUX21X1_HVT U4345 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte[2]), .A2(
        n4264), .S0(n3610), .Y(n2113) );
  NAND3X0_HVT U4346 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[1]), .A2(n5108), 
        .A3(n5016), .Y(n502) );
  INVX1_HVT U4347 ( .A(n502), .Y(n362) );
  NAND2X0_HVT U4348 ( .A1(n360), .A2(n5177), .Y(n3611) );
  MUX21X1_HVT U4349 ( .A1(AHB_I2C_WRAPPER_error), .A2(n362), .S0(n3611), .Y(
        n1877) );
  AND2X1_HVT U4351 ( .A1(n5101), .A2(n367), .Y(n4443) );
  AND2X1_HVT U4352 ( .A1(n4726), .A2(n4727), .Y(n4341) );
  NAND3X0_HVT U4353 ( .A1(n5505), .A2(n5454), .A3(n5101), .Y(n4440) );
  INVX1_HVT U4354 ( .A(n4440), .Y(n4430) );
  NAND3X0_HVT U4355 ( .A1(n4341), .A2(n4430), .A3(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_bit_counter[2]), .Y(n3614) );
  NAND2X0_HVT U4356 ( .A1(n3614), .A2(n5171), .Y(n3615) );
  MUX21X1_HVT U4357 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[4]), .A2(
        n4443), .S0(n3615), .Y(n1902) );
  NOR3X0_HVT U4359 ( .A1(HADDR[22]), .A2(HADDR[26]), .A3(HADDR[25]), .Y(n3618)
         );
  NOR4X1_HVT U4360 ( .A1(HADDR[21]), .A2(HADDR[20]), .A3(HADDR[18]), .A4(
        HADDR[23]), .Y(n3617) );
  NOR4X1_HVT U4361 ( .A1(n4871), .A2(HADDR[17]), .A3(HADDR[16]), .A4(n4870), 
        .Y(n3616) );
  NAND3X0_HVT U4362 ( .A1(n3618), .A2(n3617), .A3(n3616), .Y(n3620) );
  OR3X1_HVT U4363 ( .A1(n4872), .A2(n4874), .A3(n4868), .Y(n4054) );
  NOR4X1_HVT U4364 ( .A1(n3620), .A2(n4054), .A3(n4875), .A4(n4877), .Y(n4067)
         );
  MUX21X1_HVT U4365 ( .A1(n5268), .A2(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sel_reg), 
        .S0(n5190), .Y(n2365) );
  NOR4X1_HVT U4368 ( .A1(HADDR[13]), .A2(n4877), .A3(n4864), .A4(n4867), .Y(
        n3622) );
  NOR4X1_HVT U4369 ( .A1(HADDR[14]), .A2(HADDR[12]), .A3(n4865), .A4(n3620), 
        .Y(n3621) );
  NAND2X0_HVT U4370 ( .A1(n3622), .A2(n3621), .Y(n3623) );
  NOR3X0_HVT U4371 ( .A1(HADDR[15]), .A2(n4866), .A3(n3623), .Y(n4053) );
  AND2X1_HVT U4374 ( .A1(n4217), .A2(n4873), .Y(n4065) );
  MUX21X1_HVT U4375 ( .A1(AHB_UART_WRAPPER_AHB_UART_SUB_sel_reg), .A2(n4065), 
        .S0(n5185), .Y(n2301) );
  NAND2X0_HVT U4376 ( .A1(AHB_UART_WRAPPER_AHB_UART_SUB_READ_WAIT), .A2(
        AHB_UART_WRAPPER_AHB_UART_SUB_read_wait_counter[0]), .Y(n3636) );
  INVX1_HVT U4377 ( .A(n3636), .Y(n3628) );
  OR2X2_LVT U4378 ( .A1(AHB_UART_WRAPPER_AHB_UART_SUB_read_wait_counter[1]), 
        .A2(n3628), .Y(n3629) );
  INVX1_HVT U4379 ( .A(n3629), .Y(n3633) );
  AND3X1_HVT U4381 ( .A1(n4818), .A2(n4065), .A3(n4820), .Y(n4530) );
  NAND2X0_HVT U4383 ( .A1(n4530), .A2(n5185), .Y(n4206) );
  INVX1_HVT U4384 ( .A(n4206), .Y(n3631) );
  OR2X2_LVT U4385 ( .A1(n3631), .A2(n5105), .Y(n3632) );
  OR2X2_LVT U4386 ( .A1(n3633), .A2(n3632), .Y(n3634) );
  INVX1_HVT U4387 ( .A(n3634), .Y(n2347) );
  OR2X2_LVT U4388 ( .A1(AHB_UART_WRAPPER_AHB_UART_SUB_read_wait_counter[0]), 
        .A2(AHB_UART_WRAPPER_AHB_UART_SUB_READ_WAIT), .Y(n3635) );
  INVX1_HVT U4389 ( .A(n3635), .Y(n3640) );
  INVX1_HVT U4390 ( .A(n4206), .Y(n3638) );
  INVX1_HVT U4391 ( .A(n3636), .Y(n3637) );
  OR2X2_LVT U4392 ( .A1(n3638), .A2(n3637), .Y(n3639) );
  OR2X2_LVT U4393 ( .A1(n3640), .A2(n3639), .Y(n3641) );
  INVX1_HVT U4394 ( .A(n3641), .Y(n2348) );
  MUX21X1_HVT U4395 ( .A1(AHB_UART_WRAPPER_AHB_UART_SUB_write_reg), .A2(
        AHB_UART_WRAPPER_sl_write), .S0(n5194), .Y(n2298) );
  AND2X1_HVT U4397 ( .A1(n5179), .A2(n5506), .Y(n4413) );
  MUX21X1_HVT U4398 ( .A1(n5180), .A2(n4413), .S0(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_counter[0]), .Y(n1927) );
  MUX21X1_HVT U4499 ( .A1(AHB_UART_WRAPPER_sl_rdata[0]), .A2(uart_rdata[0]), 
        .S0(n5530), .Y(n2293) );
  MUX21X1_HVT U4500 ( .A1(AHB_UART_WRAPPER_sl_rdata[1]), .A2(uart_rdata[1]), 
        .S0(n5530), .Y(n2292) );
  MUX21X1_HVT U4501 ( .A1(n5444), .A2(uart_rdata[3]), .S0(n5530), .Y(n2290) );
  MUX21X1_HVT U4502 ( .A1(n5441), .A2(uart_rdata[2]), .S0(n5530), .Y(n2291) );
  INVX1_HVT U4503 ( .A(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_size[1]), .Y(n3683)
         );
  INVX1_HVT U4504 ( .A(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_size[0]), .Y(n3682)
         );
  INVX1_HVT U4505 ( .A(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_size[2]), .Y(n3681)
         );
  NAND4X0_HVT U4506 ( .A1(n5030), .A2(n3683), .A3(n3682), .A4(n3681), .Y(n3679) );
  NAND2X0_HVT U4507 ( .A1(n3679), .A2(n5459), .Y(n3691) );
  NAND2X0_HVT U4508 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_size[1]), .A2(
        n4667), .Y(n3680) );
  NAND2X0_HVT U4509 ( .A1(n3681), .A2(n3680), .Y(n3684) );
  NAND3X0_HVT U4510 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_counter[0]), .A2(
        n3682), .A3(n3684), .Y(n3687) );
  NAND2X0_HVT U4511 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_counter[1]), .A2(
        n3683), .Y(n3686) );
  INVX1_HVT U4512 ( .A(n3684), .Y(n3685) );
  NAND4X0_HVT U4513 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_size[0]), .A2(
        n3685), .A3(n4669), .A4(n3686), .Y(n4227) );
  OA221X1_HVT U4514 ( .A1(n3687), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_size[2]), .A3(n3687), .A4(n3686), 
        .A5(n4227), .Y(n4229) );
  OA22X1_HVT U4515 ( .A1(n3689), .A2(n3688), .A3(n4229), .A4(n4226), .Y(n3690)
         );
  NAND3X0_HVT U4516 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_STATE[0]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_STATE[1]), .A3(n5531), .Y(n4233) );
  NAND3X0_HVT U4517 ( .A1(n3690), .A2(n5135), .A3(n4233), .Y(n4225) );
  MUX21X1_HVT U4518 ( .A1(n5459), .A2(n3691), .S0(n4225), .Y(n2142) );
  MUX21X1_HVT U4519 ( .A1(AHB_I2C_WRAPPER_AHB_I2C_SUB_addr_reg[3]), .A2(
        AHB_I2C_WRAPPER_sl_addr[3]), .S0(n5196), .Y(n2021) );
  MUX21X1_HVT U4520 ( .A1(AHB_SPI_WRAPPER_AHB_SPI_SUB_addr_reg[2]), .A2(
        AHB_SPI_WRAPPER_sl_addr[2]), .S0(n5197), .Y(n2207) );
  MUX21X1_HVT U4521 ( .A1(AHB_I2C_WRAPPER_AHB_I2C_SUB_addr_reg[2]), .A2(
        AHB_I2C_WRAPPER_sl_addr[2]), .S0(n5196), .Y(n2022) );
  MUX21X1_HVT U4522 ( .A1(n5385), .A2(AHB_SPI_WRAPPER_sl_addr[3]), .S0(n5197), 
        .Y(n2206) );
  MUX21X1_HVT U4523 ( .A1(n5392), .A2(AHB_UART_WRAPPER_sl_addr[3]), .S0(n5194), 
        .Y(n2294) );
  AND4X1_HVT U4524 ( .A1(AHB_SRAM_WRAPPER_sl_wstrb[2]), .A2(
        AHB_SRAM_WRAPPER_sl_wstrb[3]), .A3(AHB_SRAM_WRAPPER_valid_trans), .A4(
        n5046), .Y(n3692) );
  AND2X1_HVT U4526 ( .A1(n5356), .A2(n3693), .Y(AHB_UART_WRAPPER_UART_REG_N109) );
  AND2X1_HVT U4527 ( .A1(n5462), .A2(n3694), .Y(AHB_SPI_WRAPPER_SPI_REG_N105)
         );
  AND2X1_HVT U4528 ( .A1(AHB_I2C_WRAPPER_sl_wdata[0]), .A2(n5473), .Y(
        AHB_I2C_WRAPPER_I2C_REG_N105) );
  INVX1_HVT U4530 ( .A(n3696), .Y(n3698) );
  OA221X1_HVT U4531 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[2]), .A2(
        n3698), .A3(n4607), .A4(n3696), .A5(n3699), .Y(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N34) );
  OA221X1_HVT U4532 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[3]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[2]), .A3(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[3]), .A4(
        n3698), .A5(n3697), .Y(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N35) );
  INVX1_HVT U4533 ( .A(n3700), .Y(n3701) );
  OA221X1_HVT U4534 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[5]), .A2(
        n3701), .A3(n4608), .A4(n3700), .A5(n3699), .Y(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N37) );
  INVX1_HVT U4535 ( .A(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_rx_counter[0]), .Y(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N32) );
  OA21X1_HVT U4537 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[0]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[1]), .A3(
        n3703), .Y(AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N17) );
  OA221X1_HVT U4538 ( .A1(n3704), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[2]), .A3(
        n3703), .A4(n3702), .A5(n3710), .Y(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N18) );
  NAND4X0_HVT U4539 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[2]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[3]), .A3(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[0]), .A4(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[1]), .Y(
        n3705) );
  OA221X1_HVT U4540 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[3]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[2]), .A3(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[3]), .A4(
        n3704), .A5(n3705), .Y(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N19) );
  INVX1_HVT U4541 ( .A(n3705), .Y(n3707) );
  OA21X1_HVT U4542 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[4]), .A2(
        n3707), .A3(n3706), .Y(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N20) );
  OA21X1_HVT U4543 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[7]), .A2(
        n3709), .A3(n3708), .Y(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N23) );
  INVX1_HVT U4544 ( .A(n3711), .Y(n3712) );
  OA221X1_HVT U4545 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[9]), .A2(
        n3712), .A3(n4609), .A4(n3711), .A5(n3710), .Y(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_N25) );
  NAND2X0_HVT U4547 ( .A1(n5490), .A2(n5293), .Y(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[0]) );
  NAND2X0_HVT U4548 ( .A1(n5486), .A2(n5293), .Y(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[1]) );
  NAND2X0_HVT U4549 ( .A1(n5468), .A2(n5293), .Y(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[2]) );
  NAND2X0_HVT U4550 ( .A1(n5399), .A2(n5293), .Y(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[3]) );
  NAND2X0_HVT U4555 ( .A1(n5525), .A2(n3728), .Y(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[8]) );
  NAND2X0_HVT U4559 ( .A1(n5518), .A2(n5293), .Y(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[12]) );
  NAND2X0_HVT U4562 ( .A1(n5517), .A2(n5293), .Y(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[15]) );
  INVX1_HVT U4565 ( .A(AHB_UART_WRAPPER_tx_data[0]), .Y(n3732) );
  OA22X1_HVT U4570 ( .A1(n5110), .A2(n4614), .A3(n3732), .A4(n3730), .Y(n3737)
         );
  NAND2X0_HVT U4572 ( .A1(AHB_UART_WRAPPER_rx_data[0]), .A2(n5128), .Y(n3736)
         );
  NAND4X0_HVT U4574 ( .A1(AHB_UART_WRAPPER_sl_addr[3]), .A2(n5504), .A3(n5367), 
        .A4(n4621), .Y(n3735) );
  NAND3X0_HVT U4575 ( .A1(AHB_UART_WRAPPER_sl_addr[2]), .A2(
        AHB_UART_WRAPPER_sl_addr[3]), .A3(n5504), .Y(n3764) );
  INVX1_HVT U4576 ( .A(n3764), .Y(n3752) );
  NAND2X0_HVT U4577 ( .A1(AHB_UART_WRAPPER_tx_start), .A2(n3752), .Y(n3734) );
  NAND4X0_HVT U4578 ( .A1(n3737), .A2(n3736), .A3(n3735), .A4(n3734), .Y(n2668) );
  INVX1_HVT U4579 ( .A(AHB_UART_WRAPPER_tx_data[1]), .Y(n3738) );
  OA22X1_HVT U4580 ( .A1(n5110), .A2(n4615), .A3(n3738), .A4(n3730), .Y(n3743)
         );
  NAND2X0_HVT U4581 ( .A1(n5128), .A2(AHB_UART_WRAPPER_rx_data[1]), .Y(n3742)
         );
  NAND2X0_HVT U4582 ( .A1(AHB_UART_WRAPPER_rx_byte_size[0]), .A2(n3752), .Y(
        n3741) );
  NAND4X0_HVT U4583 ( .A1(AHB_UART_WRAPPER_sl_addr[3]), .A2(n5504), .A3(
        AHB_UART_WRAPPER_rx_valid), .A4(n4621), .Y(n3740) );
  NAND4X0_HVT U4584 ( .A1(n3743), .A2(n3742), .A3(n3741), .A4(n3740), .Y(n2667) );
  NAND2X0_HVT U4585 ( .A1(AHB_UART_WRAPPER_rx_byte_size[1]), .A2(n3752), .Y(
        n3747) );
  NAND2X0_HVT U4586 ( .A1(AHB_UART_WRAPPER_sl_rdata[2]), .A2(n5520), .Y(n3746)
         );
  NAND2X0_HVT U4587 ( .A1(AHB_UART_WRAPPER_tx_data[2]), .A2(n5125), .Y(n3745)
         );
  NAND2X0_HVT U4588 ( .A1(n5128), .A2(AHB_UART_WRAPPER_rx_data[2]), .Y(n3744)
         );
  NAND4X0_HVT U4589 ( .A1(n3747), .A2(n3746), .A3(n3745), .A4(n3744), .Y(n2666) );
  NAND2X0_HVT U4590 ( .A1(AHB_UART_WRAPPER_sl_rdata[3]), .A2(n5520), .Y(n3751)
         );
  NAND2X0_HVT U4591 ( .A1(AHB_UART_WRAPPER_tx_data[3]), .A2(n5125), .Y(n3750)
         );
  NAND2X0_HVT U4592 ( .A1(AHB_UART_WRAPPER_rx_byte_size[2]), .A2(n3752), .Y(
        n3749) );
  NAND2X0_HVT U4593 ( .A1(n5128), .A2(AHB_UART_WRAPPER_rx_data[3]), .Y(n3748)
         );
  NAND4X0_HVT U4594 ( .A1(n3751), .A2(n3750), .A3(n3749), .A4(n3748), .Y(n2665) );
  NAND2X0_HVT U4595 ( .A1(AHB_UART_WRAPPER_sl_rdata[4]), .A2(n5520), .Y(n3756)
         );
  NAND2X0_HVT U4596 ( .A1(AHB_UART_WRAPPER_tx_data[4]), .A2(n5125), .Y(n3755)
         );
  NAND2X0_HVT U4597 ( .A1(AHB_UART_WRAPPER_tx_byte_size[0]), .A2(n3752), .Y(
        n3754) );
  NAND2X0_HVT U4598 ( .A1(n5128), .A2(AHB_UART_WRAPPER_rx_data[4]), .Y(n3753)
         );
  NAND4X0_HVT U4599 ( .A1(n3756), .A2(n3755), .A3(n3754), .A4(n3753), .Y(n2664) );
  NAND2X0_HVT U4600 ( .A1(AHB_UART_WRAPPER_sl_rdata[5]), .A2(n5520), .Y(n3762)
         );
  INVX1_HVT U4601 ( .A(AHB_UART_WRAPPER_tx_data[5]), .Y(n3758) );
  OA22X1_HVT U4602 ( .A1(n3758), .A2(n3730), .A3(n3757), .A4(n3764), .Y(n3761)
         );
  NAND2X0_HVT U4603 ( .A1(n5128), .A2(AHB_UART_WRAPPER_rx_data[5]), .Y(n3760)
         );
  NAND3X0_HVT U4604 ( .A1(n3762), .A2(n3761), .A3(n3760), .Y(n2663) );
  NAND2X0_HVT U4605 ( .A1(AHB_UART_WRAPPER_sl_rdata[6]), .A2(n5520), .Y(n3769)
         );
  INVX1_HVT U4606 ( .A(AHB_UART_WRAPPER_tx_data[6]), .Y(n3766) );
  OA22X1_HVT U4607 ( .A1(n3766), .A2(n3730), .A3(n3765), .A4(n3764), .Y(n3768)
         );
  NAND2X0_HVT U4608 ( .A1(n5128), .A2(AHB_UART_WRAPPER_rx_data[6]), .Y(n3767)
         );
  NAND3X0_HVT U4609 ( .A1(n3769), .A2(n3768), .A3(n3767), .Y(n2662) );
  INVX1_HVT U4610 ( .A(AHB_UART_WRAPPER_rx_data[7]), .Y(n3772) );
  INVX1_HVT U4613 ( .A(AHB_UART_WRAPPER_tx_data[7]), .Y(n3770) );
  OAI222X1_HVT U4614 ( .A1(n3772), .A2(n5378), .A3(n5009), .A4(n5110), .A5(
        n3770), .A6(n5526), .Y(n2661) );
  INVX1_HVT U4615 ( .A(AHB_UART_WRAPPER_rx_data[8]), .Y(n3775) );
  INVX1_HVT U4617 ( .A(AHB_UART_WRAPPER_tx_data[8]), .Y(n3773) );
  OAI222X1_HVT U4618 ( .A1(n3775), .A2(n5378), .A3(n5008), .A4(n5110), .A5(
        n3773), .A6(n5526), .Y(n2660) );
  INVX1_HVT U4619 ( .A(AHB_UART_WRAPPER_rx_data[9]), .Y(n3778) );
  INVX1_HVT U4621 ( .A(AHB_UART_WRAPPER_tx_data[9]), .Y(n3776) );
  OAI222X1_HVT U4622 ( .A1(n3778), .A2(n5378), .A3(n5007), .A4(n5110), .A5(
        n3776), .A6(n5526), .Y(n2659) );
  INVX1_HVT U4623 ( .A(AHB_UART_WRAPPER_rx_data[10]), .Y(n3781) );
  INVX1_HVT U4625 ( .A(AHB_UART_WRAPPER_tx_data[10]), .Y(n3779) );
  OAI222X1_HVT U4626 ( .A1(n3781), .A2(n5378), .A3(n5006), .A4(n5110), .A5(
        n3779), .A6(n5526), .Y(n2658) );
  INVX1_HVT U4627 ( .A(AHB_UART_WRAPPER_rx_data[11]), .Y(n3784) );
  INVX1_HVT U4629 ( .A(AHB_UART_WRAPPER_tx_data[11]), .Y(n3782) );
  OAI222X1_HVT U4630 ( .A1(n3784), .A2(n5378), .A3(n5005), .A4(n5110), .A5(
        n3782), .A6(n5526), .Y(n2657) );
  INVX1_HVT U4631 ( .A(AHB_UART_WRAPPER_rx_data[12]), .Y(n3787) );
  INVX1_HVT U4633 ( .A(AHB_UART_WRAPPER_tx_data[12]), .Y(n3785) );
  OAI222X1_HVT U4634 ( .A1(n3787), .A2(n5378), .A3(n5004), .A4(n5110), .A5(
        n3785), .A6(n5526), .Y(n2656) );
  INVX1_HVT U4635 ( .A(AHB_UART_WRAPPER_rx_data[13]), .Y(n3790) );
  INVX1_HVT U4637 ( .A(AHB_UART_WRAPPER_tx_data[13]), .Y(n3788) );
  OAI222X1_HVT U4638 ( .A1(n3790), .A2(n5378), .A3(n5003), .A4(n5110), .A5(
        n3788), .A6(n5526), .Y(n2655) );
  INVX1_HVT U4639 ( .A(AHB_UART_WRAPPER_rx_data[14]), .Y(n3793) );
  OAI222X1_HVT U4642 ( .A1(n3793), .A2(n5378), .A3(n5002), .A4(n5110), .A5(
        n4984), .A6(n5526), .Y(n2654) );
  INVX1_HVT U4643 ( .A(AHB_UART_WRAPPER_rx_data[15]), .Y(n3796) );
  INVX1_HVT U4645 ( .A(AHB_UART_WRAPPER_tx_data[15]), .Y(n3794) );
  OAI222X1_HVT U4646 ( .A1(n3796), .A2(n5378), .A3(n5001), .A4(n5110), .A5(
        n3794), .A6(n5526), .Y(n2653) );
  INVX1_HVT U4647 ( .A(AHB_UART_WRAPPER_rx_data[16]), .Y(n3801) );
  INVX1_HVT U4649 ( .A(AHB_UART_WRAPPER_tx_data[16]), .Y(n3798) );
  OAI222X1_HVT U4650 ( .A1(n3801), .A2(n5378), .A3(n5000), .A4(n5110), .A5(
        n3798), .A6(n5526), .Y(n2652) );
  INVX1_HVT U4651 ( .A(AHB_UART_WRAPPER_rx_data[17]), .Y(n3806) );
  OAI222X1_HVT U4656 ( .A1(n3806), .A2(n5378), .A3(n4999), .A4(n5110), .A5(
        n4983), .A6(n5526), .Y(n2651) );
  INVX1_HVT U4657 ( .A(AHB_UART_WRAPPER_rx_data[18]), .Y(n3809) );
  INVX1_HVT U4659 ( .A(AHB_UART_WRAPPER_tx_data[18]), .Y(n3807) );
  OAI222X1_HVT U4660 ( .A1(n3809), .A2(n5378), .A3(n4998), .A4(n5110), .A5(
        n3807), .A6(n5526), .Y(n2650) );
  INVX1_HVT U4661 ( .A(AHB_UART_WRAPPER_rx_data[19]), .Y(n3812) );
  OAI222X1_HVT U4664 ( .A1(n3812), .A2(n5378), .A3(n4997), .A4(n5110), .A5(
        n4982), .A6(n5526), .Y(n2649) );
  INVX1_HVT U4665 ( .A(AHB_UART_WRAPPER_rx_data[20]), .Y(n3815) );
  OAI222X1_HVT U4668 ( .A1(n3815), .A2(n5378), .A3(n4996), .A4(n5110), .A5(
        n4981), .A6(n5526), .Y(n2648) );
  INVX1_HVT U4669 ( .A(AHB_UART_WRAPPER_rx_data[21]), .Y(n3819) );
  OAI222X1_HVT U4672 ( .A1(n3819), .A2(n5378), .A3(n4995), .A4(n5110), .A5(
        n4980), .A6(n5526), .Y(n2647) );
  INVX1_HVT U4673 ( .A(AHB_UART_WRAPPER_rx_data[22]), .Y(n3822) );
  INVX1_HVT U4676 ( .A(AHB_UART_WRAPPER_tx_data[22]), .Y(n3820) );
  OAI222X1_HVT U4677 ( .A1(n3822), .A2(n5378), .A3(n4994), .A4(n5110), .A5(
        n3820), .A6(n5526), .Y(n2646) );
  INVX1_HVT U4678 ( .A(AHB_UART_WRAPPER_rx_data[23]), .Y(n3825) );
  OAI222X1_HVT U4681 ( .A1(n3825), .A2(n5378), .A3(n4993), .A4(n5110), .A5(
        n4979), .A6(n5526), .Y(n2645) );
  INVX1_HVT U4682 ( .A(AHB_UART_WRAPPER_rx_data[24]), .Y(n3828) );
  OAI222X1_HVT U4685 ( .A1(n3828), .A2(n5378), .A3(n4992), .A4(n5110), .A5(
        n4978), .A6(n5526), .Y(n2644) );
  INVX1_HVT U4686 ( .A(AHB_UART_WRAPPER_rx_data[25]), .Y(n3831) );
  OAI222X1_HVT U4689 ( .A1(n3831), .A2(n5378), .A3(n4991), .A4(n5110), .A5(
        n4977), .A6(n5526), .Y(n2643) );
  INVX1_HVT U4690 ( .A(AHB_UART_WRAPPER_rx_data[26]), .Y(n3834) );
  INVX1_HVT U4692 ( .A(AHB_UART_WRAPPER_tx_data[26]), .Y(n3832) );
  OAI222X1_HVT U4693 ( .A1(n3834), .A2(n5378), .A3(n4990), .A4(n5110), .A5(
        n3832), .A6(n5526), .Y(n2642) );
  INVX1_HVT U4694 ( .A(AHB_UART_WRAPPER_rx_data[27]), .Y(n3837) );
  INVX1_HVT U4696 ( .A(AHB_UART_WRAPPER_tx_data[27]), .Y(n3835) );
  OAI222X1_HVT U4697 ( .A1(n3837), .A2(n5378), .A3(n4989), .A4(n5110), .A5(
        n3835), .A6(n5526), .Y(n2641) );
  INVX1_HVT U4698 ( .A(AHB_UART_WRAPPER_rx_data[28]), .Y(n3839) );
  OAI222X1_HVT U4700 ( .A1(n3839), .A2(n5378), .A3(n4988), .A4(n5110), .A5(
        n4616), .A6(n5526), .Y(n2640) );
  INVX1_HVT U4701 ( .A(AHB_UART_WRAPPER_rx_data[29]), .Y(n3841) );
  OAI222X1_HVT U4703 ( .A1(n3841), .A2(n5378), .A3(n4987), .A4(n5110), .A5(
        n4617), .A6(n5526), .Y(n2639) );
  INVX1_HVT U4704 ( .A(AHB_UART_WRAPPER_rx_data[30]), .Y(n3843) );
  OAI222X1_HVT U4706 ( .A1(n3843), .A2(n5378), .A3(n4986), .A4(n5110), .A5(
        n4618), .A6(n5526), .Y(n2638) );
  INVX1_HVT U4707 ( .A(AHB_UART_WRAPPER_rx_data[31]), .Y(n3848) );
  OAI222X1_HVT U4709 ( .A1(n3848), .A2(n5378), .A3(n4985), .A4(n5110), .A5(
        n4619), .A6(n5526), .Y(n2637) );
  MUX21X1_HVT U4711 ( .A1(AHB_UART_WRAPPER_sl_wdata[28]), .A2(
        AHB_UART_WRAPPER_tx_data[28]), .S0(n2720), .Y(n2608) );
  MUX21X1_HVT U4712 ( .A1(n5333), .A2(AHB_UART_WRAPPER_tx_data[29]), .S0(n5512), .Y(n2607) );
  MUX21X1_HVT U4713 ( .A1(n5352), .A2(AHB_UART_WRAPPER_tx_data[30]), .S0(n5512), .Y(n2606) );
  MUX21X1_HVT U4714 ( .A1(n5338), .A2(AHB_UART_WRAPPER_tx_data[31]), .S0(n5512), .Y(n2605) );
  NOR3X0_HVT U4716 ( .A1(AHB_SPI_WRAPPER_sl_addr[0]), .A2(
        AHB_SPI_WRAPPER_sl_addr[1]), .A3(n3889), .Y(n3852) );
  NAND3X0_HVT U4717 ( .A1(AHB_SPI_WRAPPER_sl_addr[3]), .A2(n3852), .A3(n3853), 
        .Y(n3865) );
  OA22X1_HVT U4721 ( .A1(n5121), .A2(n3865), .A3(n5527), .A4(n4671), .Y(n3859)
         );
  NAND2X0_HVT U4723 ( .A1(AHB_SPI_WRAPPER_spi_start), .A2(n3891), .Y(n3858) );
  NAND2X0_HVT U4727 ( .A1(AHB_SPI_WRAPPER_tx_data[0]), .A2(n5124), .Y(n3857)
         );
  NAND2X0_HVT U4728 ( .A1(AHB_SPI_WRAPPER_sl_rdata[0]), .A2(n3889), .Y(n3856)
         );
  NAND4X0_HVT U4729 ( .A1(n3859), .A2(n3858), .A3(n3857), .A4(n3856), .Y(n2598) );
  NAND2X0_HVT U4730 ( .A1(AHB_SPI_WRAPPER_tx_byte_size[0]), .A2(n3891), .Y(
        n3863) );
  INVX1_HVT U4732 ( .A(AHB_SPI_WRAPPER_tx_data[1]), .Y(n3860) );
  OA22X1_HVT U4733 ( .A1(n3865), .A2(n4623), .A3(n3854), .A4(n3860), .Y(n3862)
         );
  OA22X1_HVT U4736 ( .A1(n5107), .A2(n4624), .A3(n4675), .A4(n3851), .Y(n3861)
         );
  NAND3X0_HVT U4737 ( .A1(n3863), .A2(n3862), .A3(n3861), .Y(n2597) );
  NAND2X0_HVT U4738 ( .A1(AHB_SPI_WRAPPER_tx_byte_size[1]), .A2(n3891), .Y(
        n3868) );
  INVX1_HVT U4739 ( .A(AHB_SPI_WRAPPER_tx_data[2]), .Y(n3864) );
  OA22X1_HVT U4740 ( .A1(n3865), .A2(n4625), .A3(n3854), .A4(n3864), .Y(n3867)
         );
  OA22X1_HVT U4741 ( .A1(n5107), .A2(n4626), .A3(n4681), .A4(n5527), .Y(n3866)
         );
  NAND3X0_HVT U4742 ( .A1(n3868), .A2(n3867), .A3(n3866), .Y(n2596) );
  NAND2X0_HVT U4743 ( .A1(AHB_SPI_WRAPPER_sl_rdata[3]), .A2(n3889), .Y(n3872)
         );
  INVX1_HVT U4744 ( .A(AHB_SPI_WRAPPER_tx_data[3]), .Y(n3869) );
  OA22X1_HVT U4745 ( .A1(n4685), .A2(n5527), .A3(n5511), .A4(n3869), .Y(n3871)
         );
  NAND2X0_HVT U4746 ( .A1(n3891), .A2(AHB_SPI_WRAPPER_tx_byte_size[2]), .Y(
        n3870) );
  NAND3X0_HVT U4747 ( .A1(n3872), .A2(n3871), .A3(n3870), .Y(n2595) );
  NAND2X0_HVT U4748 ( .A1(AHB_SPI_WRAPPER_sl_rdata[4]), .A2(n3889), .Y(n3876)
         );
  INVX1_HVT U4749 ( .A(AHB_SPI_WRAPPER_tx_data[4]), .Y(n3873) );
  OA22X1_HVT U4750 ( .A1(n4690), .A2(n3851), .A3(n3854), .A4(n3873), .Y(n3875)
         );
  NAND2X0_HVT U4751 ( .A1(n3891), .A2(AHB_SPI_WRAPPER_rx_byte_size[0]), .Y(
        n3874) );
  NAND3X0_HVT U4752 ( .A1(n3876), .A2(n3875), .A3(n3874), .Y(n2594) );
  NAND2X0_HVT U4753 ( .A1(AHB_SPI_WRAPPER_sl_rdata[5]), .A2(n3889), .Y(n3880)
         );
  INVX1_HVT U4754 ( .A(AHB_SPI_WRAPPER_tx_data[5]), .Y(n3877) );
  OA22X1_HVT U4755 ( .A1(n4695), .A2(n3851), .A3(n3854), .A4(n3877), .Y(n3879)
         );
  NAND2X0_HVT U4756 ( .A1(n3891), .A2(AHB_SPI_WRAPPER_rx_byte_size[1]), .Y(
        n3878) );
  NAND3X0_HVT U4757 ( .A1(n3880), .A2(n3879), .A3(n3878), .Y(n2593) );
  NAND2X0_HVT U4758 ( .A1(AHB_SPI_WRAPPER_sl_rdata[6]), .A2(n3889), .Y(n3884)
         );
  INVX1_HVT U4759 ( .A(AHB_SPI_WRAPPER_tx_data[6]), .Y(n3881) );
  OA22X1_HVT U4760 ( .A1(n4700), .A2(n3851), .A3(n5511), .A4(n3881), .Y(n3883)
         );
  NAND2X0_HVT U4761 ( .A1(n3891), .A2(AHB_SPI_WRAPPER_rx_byte_size[2]), .Y(
        n3882) );
  NAND3X0_HVT U4762 ( .A1(n3884), .A2(n3883), .A3(n3882), .Y(n2592) );
  NAND2X0_HVT U4763 ( .A1(AHB_SPI_WRAPPER_sl_rdata[7]), .A2(n3889), .Y(n3888)
         );
  INVX1_HVT U4764 ( .A(AHB_SPI_WRAPPER_tx_data[7]), .Y(n3885) );
  OA22X1_HVT U4765 ( .A1(n4705), .A2(n3851), .A3(n3854), .A4(n3885), .Y(n3887)
         );
  NAND2X0_HVT U4766 ( .A1(n3891), .A2(AHB_SPI_WRAPPER_slave_select[0]), .Y(
        n3886) );
  NAND3X0_HVT U4767 ( .A1(n3888), .A2(n3887), .A3(n3886), .Y(n2591) );
  NAND2X0_HVT U4768 ( .A1(AHB_SPI_WRAPPER_sl_rdata[8]), .A2(n3889), .Y(n3894)
         );
  INVX1_HVT U4769 ( .A(AHB_SPI_WRAPPER_tx_data[8]), .Y(n3890) );
  OA22X1_HVT U4770 ( .A1(n4670), .A2(n3851), .A3(n3854), .A4(n3890), .Y(n3893)
         );
  NAND2X0_HVT U4771 ( .A1(n3891), .A2(AHB_SPI_WRAPPER_slave_select[1]), .Y(
        n3892) );
  NAND3X0_HVT U4772 ( .A1(n3894), .A2(n3893), .A3(n3892), .Y(n2590) );
  INVX1_HVT U4773 ( .A(AHB_SPI_WRAPPER_tx_data[9]), .Y(n3897) );
  OAI222X1_HVT U4776 ( .A1(n3897), .A2(n5511), .A3(n4976), .A4(n5107), .A5(
        n4674), .A6(n5527), .Y(n2589) );
  INVX1_HVT U4777 ( .A(AHB_SPI_WRAPPER_tx_data[10]), .Y(n3899) );
  OAI222X1_HVT U4780 ( .A1(n3899), .A2(n5511), .A3(n4975), .A4(n5107), .A5(
        n4680), .A6(n5527), .Y(n2588) );
  INVX1_HVT U4781 ( .A(AHB_SPI_WRAPPER_tx_data[11]), .Y(n3901) );
  OAI222X1_HVT U4783 ( .A1(n3901), .A2(n5511), .A3(n4974), .A4(n5107), .A5(
        n4684), .A6(n5527), .Y(n2587) );
  INVX1_HVT U4784 ( .A(AHB_SPI_WRAPPER_tx_data[12]), .Y(n3903) );
  OAI222X1_HVT U4786 ( .A1(n3903), .A2(n5511), .A3(n4973), .A4(n5107), .A5(
        n4689), .A6(n5527), .Y(n2586) );
  INVX1_HVT U4787 ( .A(AHB_SPI_WRAPPER_tx_data[13]), .Y(n3905) );
  OAI222X1_HVT U4789 ( .A1(n3905), .A2(n5511), .A3(n4972), .A4(n5107), .A5(
        n4694), .A6(n5527), .Y(n2585) );
  INVX1_HVT U4790 ( .A(AHB_SPI_WRAPPER_tx_data[14]), .Y(n3907) );
  OAI222X1_HVT U4792 ( .A1(n3907), .A2(n5511), .A3(n4971), .A4(n5107), .A5(
        n4699), .A6(n5527), .Y(n2584) );
  INVX1_HVT U4793 ( .A(AHB_SPI_WRAPPER_tx_data[15]), .Y(n3909) );
  OAI222X1_HVT U4795 ( .A1(n3909), .A2(n5511), .A3(n4970), .A4(n5107), .A5(
        n4704), .A6(n5527), .Y(n2583) );
  INVX1_HVT U4796 ( .A(AHB_SPI_WRAPPER_tx_data[16]), .Y(n3912) );
  OAI222X1_HVT U4798 ( .A1(n3912), .A2(n5511), .A3(n4969), .A4(n5107), .A5(
        n4668), .A6(n5527), .Y(n2582) );
  INVX1_HVT U4799 ( .A(AHB_SPI_WRAPPER_tx_data[17]), .Y(n3915) );
  OAI222X1_HVT U4802 ( .A1(n3915), .A2(n5511), .A3(n4968), .A4(n5107), .A5(
        n4673), .A6(n5527), .Y(n2581) );
  INVX1_HVT U4803 ( .A(AHB_SPI_WRAPPER_tx_data[18]), .Y(n3917) );
  OAI222X1_HVT U4805 ( .A1(n3917), .A2(n5511), .A3(n4967), .A4(n5107), .A5(
        n4679), .A6(n5527), .Y(n2580) );
  INVX1_HVT U4806 ( .A(AHB_SPI_WRAPPER_tx_data[19]), .Y(n3919) );
  OAI222X1_HVT U4808 ( .A1(n3919), .A2(n5511), .A3(n4966), .A4(n5107), .A5(
        n4683), .A6(n5527), .Y(n2579) );
  INVX1_HVT U4809 ( .A(AHB_SPI_WRAPPER_tx_data[20]), .Y(n3921) );
  OAI222X1_HVT U4811 ( .A1(n3921), .A2(n5511), .A3(n4965), .A4(n5107), .A5(
        n4688), .A6(n5527), .Y(n2578) );
  OAI222X1_HVT U4814 ( .A1(n4957), .A2(n5511), .A3(n4964), .A4(n5107), .A5(
        n4693), .A6(n5527), .Y(n2577) );
  INVX1_HVT U4815 ( .A(AHB_SPI_WRAPPER_tx_data[22]), .Y(n3925) );
  OAI222X1_HVT U4817 ( .A1(n3925), .A2(n5511), .A3(n4963), .A4(n5107), .A5(
        n4698), .A6(n5527), .Y(n2576) );
  OAI222X1_HVT U4820 ( .A1(n4956), .A2(n5511), .A3(n4962), .A4(n5107), .A5(
        n4703), .A6(n5527), .Y(n2575) );
  INVX1_HVT U4822 ( .A(AHB_SPI_WRAPPER_tx_data[24]), .Y(n3928) );
  OAI222X1_HVT U4823 ( .A1(n5527), .A2(n4666), .A3(n4961), .A4(n5107), .A5(
        n3928), .A6(n5511), .Y(n2574) );
  INVX1_HVT U4825 ( .A(AHB_SPI_WRAPPER_tx_data[25]), .Y(n3930) );
  OAI222X1_HVT U4826 ( .A1(n5527), .A2(n4672), .A3(n4960), .A4(n5107), .A5(
        n3930), .A6(n5511), .Y(n2573) );
  INVX1_HVT U4828 ( .A(AHB_SPI_WRAPPER_tx_data[26]), .Y(n3932) );
  OAI222X1_HVT U4829 ( .A1(n5527), .A2(n4678), .A3(n4959), .A4(n5107), .A5(
        n3932), .A6(n5511), .Y(n2572) );
  OAI222X1_HVT U4832 ( .A1(n5527), .A2(n4682), .A3(n4958), .A4(n5107), .A5(
        n4955), .A6(n5511), .Y(n2571) );
  INVX1_HVT U4834 ( .A(AHB_SPI_WRAPPER_sl_rdata[28]), .Y(n3937) );
  OAI222X1_HVT U4835 ( .A1(n5527), .A2(n4687), .A3(n3937), .A4(n5107), .A5(
        n4627), .A6(n5511), .Y(n2570) );
  INVX1_HVT U4836 ( .A(AHB_SPI_WRAPPER_sl_rdata[29]), .Y(n3939) );
  OAI222X1_HVT U4837 ( .A1(n5527), .A2(n4692), .A3(n3939), .A4(n5107), .A5(
        n4628), .A6(n5511), .Y(n2569) );
  INVX1_HVT U4838 ( .A(AHB_SPI_WRAPPER_sl_rdata[30]), .Y(n3941) );
  OAI222X1_HVT U4839 ( .A1(n3851), .A2(n4697), .A3(n3941), .A4(n5107), .A5(
        n4629), .A6(n5511), .Y(n2568) );
  INVX1_HVT U4840 ( .A(AHB_SPI_WRAPPER_sl_rdata[31]), .Y(n3945) );
  OAI222X1_HVT U4841 ( .A1(n5511), .A2(n4630), .A3(n3945), .A4(n5107), .A5(
        n4702), .A6(n5527), .Y(n2567) );
  MUX21X1_HVT U4843 ( .A1(AHB_SPI_WRAPPER_sl_wdata[28]), .A2(
        AHB_SPI_WRAPPER_tx_data[28]), .S0(n5528), .Y(n2538) );
  MUX21X1_HVT U4844 ( .A1(AHB_SPI_WRAPPER_sl_wdata[29]), .A2(
        AHB_SPI_WRAPPER_tx_data[29]), .S0(n5528), .Y(n2537) );
  MUX21X1_HVT U4845 ( .A1(AHB_SPI_WRAPPER_sl_wdata[30]), .A2(
        AHB_SPI_WRAPPER_tx_data[30]), .S0(n5528), .Y(n2536) );
  MUX21X1_HVT U4846 ( .A1(AHB_SPI_WRAPPER_sl_wdata[31]), .A2(
        AHB_SPI_WRAPPER_tx_data[31]), .S0(n5528), .Y(n2535) );
  AND3X1_HVT U4847 ( .A1(AHB_SPI_WRAPPER_error), .A2(n5135), .A3(n4233), .Y(
        n2526) );
  NOR3X0_HVT U4849 ( .A1(AHB_I2C_WRAPPER_sl_addr[0]), .A2(
        AHB_I2C_WRAPPER_sl_addr[1]), .A3(n3994), .Y(n3952) );
  OA22X1_HVT U4852 ( .A1(n5132), .A2(n3964), .A3(n4712), .A4(n3988), .Y(n3957)
         );
  NAND2X0_HVT U4856 ( .A1(AHB_I2C_WRAPPER_tx_data[0]), .A2(n5123), .Y(n3956)
         );
  NAND2X0_HVT U4857 ( .A1(AHB_I2C_WRAPPER_sl_rdata[0]), .A2(n3994), .Y(n3955)
         );
  NAND2X0_HVT U4861 ( .A1(AHB_I2C_WRAPPER_rx_data[0]), .A2(n5122), .Y(n3954)
         );
  NAND4X0_HVT U4862 ( .A1(n3957), .A2(n3956), .A3(n3955), .A4(n3954), .Y(n2525) );
  INVX1_HVT U4863 ( .A(AHB_I2C_WRAPPER_tx_byte_size[0]), .Y(n3958) );
  OA22X1_HVT U4864 ( .A1(n5508), .A2(n3958), .A3(n5384), .A4(n4720), .Y(n3962)
         );
  NAND2X0_HVT U4865 ( .A1(n5123), .A2(AHB_I2C_WRAPPER_tx_data[1]), .Y(n3961)
         );
  NAND2X0_HVT U4866 ( .A1(n5122), .A2(AHB_I2C_WRAPPER_rx_data[1]), .Y(n3960)
         );
  NAND2X0_HVT U4867 ( .A1(AHB_I2C_WRAPPER_sl_rdata[1]), .A2(n3994), .Y(n3959)
         );
  NAND4X0_HVT U4868 ( .A1(n3962), .A2(n3961), .A3(n3960), .A4(n3959), .Y(n2524) );
  INVX1_HVT U4869 ( .A(AHB_I2C_WRAPPER_tx_byte_size[1]), .Y(n3965) );
  INVX1_HVT U4870 ( .A(AHB_I2C_WRAPPER_error), .Y(n3963) );
  OA22X1_HVT U4871 ( .A1(n5508), .A2(n3965), .A3(n5384), .A4(n3963), .Y(n3969)
         );
  NAND2X0_HVT U4872 ( .A1(n5123), .A2(AHB_I2C_WRAPPER_tx_data[2]), .Y(n3968)
         );
  NAND2X0_HVT U4873 ( .A1(AHB_I2C_WRAPPER_sl_rdata[2]), .A2(n3994), .Y(n3967)
         );
  NAND2X0_HVT U4874 ( .A1(n5122), .A2(AHB_I2C_WRAPPER_rx_data[2]), .Y(n3966)
         );
  NAND4X0_HVT U4875 ( .A1(n3969), .A2(n3968), .A3(n3967), .A4(n3966), .Y(n2523) );
  NAND2X0_HVT U4876 ( .A1(n5345), .A2(n3994), .Y(n3975) );
  INVX1_HVT U4877 ( .A(AHB_I2C_WRAPPER_tx_byte_size[2]), .Y(n3971) );
  OA22X1_HVT U4880 ( .A1(n5508), .A2(n3971), .A3(n3950), .A4(n4934), .Y(n3974)
         );
  NAND2X0_HVT U4882 ( .A1(n5122), .A2(AHB_I2C_WRAPPER_rx_data[3]), .Y(n3973)
         );
  NAND2X0_HVT U4884 ( .A1(AHB_I2C_WRAPPER_sl_rdata[4]), .A2(n3994), .Y(n3980)
         );
  OA22X1_HVT U4887 ( .A1(n5508), .A2(n4937), .A3(n5533), .A4(n4933), .Y(n3979)
         );
  NAND2X0_HVT U4888 ( .A1(n5122), .A2(AHB_I2C_WRAPPER_rx_data[4]), .Y(n3978)
         );
  NAND3X0_HVT U4889 ( .A1(n3980), .A2(n3979), .A3(n3978), .Y(n2521) );
  NAND2X0_HVT U4890 ( .A1(AHB_I2C_WRAPPER_sl_rdata[5]), .A2(n3994), .Y(n3985)
         );
  OA22X1_HVT U4893 ( .A1(n5508), .A2(n4936), .A3(n5533), .A4(n4932), .Y(n3984)
         );
  NAND2X0_HVT U4894 ( .A1(n5122), .A2(AHB_I2C_WRAPPER_rx_data[5]), .Y(n3983)
         );
  NAND3X0_HVT U4895 ( .A1(n3985), .A2(n3984), .A3(n3983), .Y(n2520) );
  NAND2X0_HVT U4896 ( .A1(AHB_I2C_WRAPPER_sl_rdata[6]), .A2(n3994), .Y(n3992)
         );
  INVX1_HVT U4898 ( .A(AHB_I2C_WRAPPER_tx_data[6]), .Y(n3986) );
  OA22X1_HVT U4899 ( .A1(n5508), .A2(n4935), .A3(n5533), .A4(n3986), .Y(n3991)
         );
  NAND2X0_HVT U4900 ( .A1(n5122), .A2(AHB_I2C_WRAPPER_rx_data[6]), .Y(n3990)
         );
  NAND3X0_HVT U4901 ( .A1(n3992), .A2(n3991), .A3(n3990), .Y(n2519) );
  INVX1_HVT U4902 ( .A(AHB_I2C_WRAPPER_tx_data[7]), .Y(n3996) );
  INVX1_HVT U4904 ( .A(AHB_I2C_WRAPPER_sl_rdata[7]), .Y(n3995) );
  OAI222X1_HVT U4908 ( .A1(n3996), .A2(n5533), .A3(n3995), .A4(n5106), .A5(
        n4633), .A6(n5491), .Y(n2518) );
  INVX1_HVT U4909 ( .A(AHB_I2C_WRAPPER_tx_data[8]), .Y(n3998) );
  OAI222X1_HVT U4911 ( .A1(n3998), .A2(n5533), .A3(n4953), .A4(n5106), .A5(
        n4634), .A6(n5491), .Y(n2517) );
  INVX1_HVT U4912 ( .A(AHB_I2C_WRAPPER_tx_data[9]), .Y(n4000) );
  OAI222X1_HVT U4914 ( .A1(n4000), .A2(n5533), .A3(n4952), .A4(n5106), .A5(
        n4635), .A6(n5491), .Y(n2516) );
  INVX1_HVT U4915 ( .A(AHB_I2C_WRAPPER_tx_data[10]), .Y(n4002) );
  INVX1_HVT U4916 ( .A(AHB_I2C_WRAPPER_sl_rdata[10]), .Y(n4001) );
  OAI222X1_HVT U4917 ( .A1(n4002), .A2(n5533), .A3(n4001), .A4(n5106), .A5(
        n4636), .A6(n5491), .Y(n2515) );
  INVX1_HVT U4919 ( .A(AHB_I2C_WRAPPER_sl_rdata[11]), .Y(n4003) );
  OAI222X1_HVT U4920 ( .A1(n4931), .A2(n5533), .A3(n4003), .A4(n5106), .A5(
        n4637), .A6(n5491), .Y(n2514) );
  INVX1_HVT U4922 ( .A(AHB_I2C_WRAPPER_sl_rdata[12]), .Y(n4005) );
  OAI222X1_HVT U4923 ( .A1(n4930), .A2(n5533), .A3(n4005), .A4(n5106), .A5(
        n4638), .A6(n5491), .Y(n2513) );
  INVX1_HVT U4925 ( .A(AHB_I2C_WRAPPER_sl_rdata[13]), .Y(n4007) );
  OAI222X1_HVT U4926 ( .A1(n4929), .A2(n5533), .A3(n4007), .A4(n5106), .A5(
        n4639), .A6(n5491), .Y(n2512) );
  INVX1_HVT U4927 ( .A(AHB_I2C_WRAPPER_tx_data[14]), .Y(n4010) );
  INVX1_HVT U4928 ( .A(AHB_I2C_WRAPPER_sl_rdata[14]), .Y(n4009) );
  OAI222X1_HVT U4929 ( .A1(n4010), .A2(n5533), .A3(n4009), .A4(n5106), .A5(
        n4640), .A6(n5491), .Y(n2511) );
  INVX1_HVT U4931 ( .A(AHB_I2C_WRAPPER_sl_rdata[15]), .Y(n4011) );
  OAI222X1_HVT U4932 ( .A1(n4928), .A2(n5533), .A3(n4011), .A4(n5106), .A5(
        n4641), .A6(n5491), .Y(n2510) );
  INVX1_HVT U4934 ( .A(AHB_I2C_WRAPPER_sl_rdata[16]), .Y(n4013) );
  OAI222X1_HVT U4935 ( .A1(n4927), .A2(n5533), .A3(n4013), .A4(n5106), .A5(
        n4642), .A6(n5491), .Y(n2509) );
  OAI222X1_HVT U4938 ( .A1(n4926), .A2(n5533), .A3(n4951), .A4(n5106), .A5(
        n4643), .A6(n5491), .Y(n2508) );
  INVX1_HVT U4948 ( .A(AHB_I2C_WRAPPER_tx_data[21]), .Y(n4026) );
  OAI222X1_HVT U4950 ( .A1(n4026), .A2(n5533), .A3(n4947), .A4(n5106), .A5(
        n4647), .A6(n5491), .Y(n2504) );
  OAI222X1_HVT U4955 ( .A1(n4922), .A2(n5533), .A3(n4946), .A4(n5106), .A5(
        n4648), .A6(n5491), .Y(n2503) );
  INVX1_HVT U4957 ( .A(AHB_I2C_WRAPPER_sl_rdata[23]), .Y(n4031) );
  OAI222X1_HVT U4958 ( .A1(n4921), .A2(n5533), .A3(n4031), .A4(n5106), .A5(
        n4649), .A6(n5491), .Y(n2502) );
  INVX1_HVT U4959 ( .A(AHB_I2C_WRAPPER_tx_data[24]), .Y(n4035) );
  OAI222X1_HVT U4961 ( .A1(n4035), .A2(n5533), .A3(n4945), .A4(n5106), .A5(
        n4650), .A6(n5491), .Y(n2501) );
  OAI222X1_HVT U4963 ( .A1(n4651), .A2(n5491), .A3(n4944), .A4(n5106), .A5(
        n4920), .A6(n5533), .Y(n2500) );
  OAI222X1_HVT U4966 ( .A1(n4652), .A2(n5491), .A3(n4943), .A4(n5106), .A5(
        n4919), .A6(n5533), .Y(n2499) );
  OAI222X1_HVT U4970 ( .A1(n4655), .A2(n5491), .A3(n4941), .A4(n5106), .A5(
        n4654), .A6(n5533), .Y(n2497) );
  OAI222X1_HVT U4972 ( .A1(n4657), .A2(n5491), .A3(n4940), .A4(n5106), .A5(
        n4656), .A6(n5533), .Y(n2496) );
  MUX21X1_HVT U4978 ( .A1(AHB_I2C_WRAPPER_sl_wdata[28]), .A2(
        AHB_I2C_WRAPPER_tx_data[28]), .S0(n2716), .Y(n2462) );
  MUX21X1_HVT U4979 ( .A1(AHB_I2C_WRAPPER_sl_wdata[29]), .A2(
        AHB_I2C_WRAPPER_tx_data[29]), .S0(n2716), .Y(n2461) );
  MUX21X1_HVT U4980 ( .A1(AHB_I2C_WRAPPER_sl_wdata[30]), .A2(
        AHB_I2C_WRAPPER_tx_data[30]), .S0(n2716), .Y(n2460) );
  MUX21X1_HVT U4981 ( .A1(AHB_I2C_WRAPPER_sl_wdata[31]), .A2(
        AHB_I2C_WRAPPER_tx_data[31]), .S0(n2716), .Y(n2459) );
  INVX1_HVT U4983 ( .A(n4053), .Y(n4057) );
  OR2X2_LVT U4986 ( .A1(n4057), .A2(n4054), .Y(n4058) );
  OR2X2_LVT U4987 ( .A1(n4876), .A2(n4058), .Y(n4060) );
  INVX1_HVT U4988 ( .A(n4060), .Y(n4317) );
  OAI21X1_HVT U4989 ( .A1(n4065), .A2(n4317), .A3(n5483), .Y(n4061) );
  NAND2X0_HVT U4990 ( .A1(n4062), .A2(n4061), .Y(n2455) );
  OAI21X1_HVT U4991 ( .A1(n4217), .A2(n4317), .A3(n5483), .Y(n4064) );
  OAI22X1_HVT U4992 ( .A1(n4065), .A2(n4064), .A3(n4063), .A4(n5435), .Y(n2454) );
  NAND3X0_HVT U4993 ( .A1(n4818), .A2(n5483), .A3(n4820), .Y(n4555) );
  OA21X1_HVT U4995 ( .A1(n4555), .A2(n5113), .A3(n4662), .Y(n4526) );
  INVX1_HVT U4996 ( .A(n4526), .Y(n4069) );
  AND2X1_HVT U4997 ( .A1(n4069), .A2(n5501), .Y(n2453) );
  INVX1_HVT U4998 ( .A(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_read_wait_counter[1]), 
        .Y(n4070) );
  OA222X1_HVT U4999 ( .A1(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_read_wait_counter[1]), 
        .A2(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_READ_WAIT), .A3(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_read_wait_counter[1]), .A4(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_read_wait_counter[0]), .A5(n4526), .A6(
        n4070), .Y(n2452) );
  OA222X1_HVT U5000 ( .A1(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_read_wait_counter[0]), 
        .A2(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_READ_WAIT), .A3(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_read_wait_counter[0]), .A4(n4070), .A5(
        n4526), .A6(n4661), .Y(n2451) );
  NAND2X0_HVT U5002 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[28]), .Y(n4077) );
  NAND2X0_HVT U5003 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[28]), .Y(n4076) );
  NAND2X0_HVT U5004 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[28]), .Y(n4075) );
  NAND4X0_HVT U5005 ( .A1(n4078), .A2(n4077), .A3(n4076), .A4(n4075), .Y(n4106) );
  NAND2X0_HVT U5006 ( .A1(n5274), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[28]), .Y(n4086) );
  NAND2X0_HVT U5008 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[28]), .Y(n4084) );
  NAND2X0_HVT U5009 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[28]), .Y(n4083) );
  NAND4X0_HVT U5010 ( .A1(n4086), .A2(n4085), .A3(n4084), .A4(n4083), .Y(n4105) );
  NAND2X0_HVT U5012 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[28]), .Y(n4093) );
  NAND2X0_HVT U5016 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[28]), .Y(n4102) );
  NAND2X0_HVT U5018 ( .A1(n2791), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[28]), .Y(n4100) );
  NAND2X0_HVT U5019 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[28]), .Y(n4099) );
  NAND4X0_HVT U5020 ( .A1(n4102), .A2(n5134), .A3(n4100), .A4(n4099), .Y(n4103) );
  MUX21X1_HVT U5023 ( .A1(sram_rdata[28]), .A2(n4108), .S0(n5103), .Y(n2422)
         );
  NAND2X0_HVT U5025 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[29]), .Y(n4116) );
  NAND2X0_HVT U5029 ( .A1(n2791), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[29]), .Y(n4114) );
  NAND2X0_HVT U5031 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[29]), .Y(n4113) );
  NAND4X0_HVT U5032 ( .A1(n4116), .A2(n4115), .A3(n4114), .A4(n4113), .Y(n4144) );
  NAND2X0_HVT U5034 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[29]), .Y(n4124) );
  NAND2X0_HVT U5040 ( .A1(n5458), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[29]), .Y(n4121) );
  NAND4X0_HVT U5041 ( .A1(n4124), .A2(n4123), .A3(n4122), .A4(n4121), .Y(n4143) );
  NAND2X0_HVT U5043 ( .A1(n5518), .A2(n5097), .Y(n4132) );
  NAND2X0_HVT U5045 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[29]), .Y(n4131) );
  NAND2X0_HVT U5047 ( .A1(n5517), .A2(n5100), .Y(n4130) );
  NAND4X0_HVT U5050 ( .A1(n4132), .A2(n4131), .A3(n4130), .A4(n4129), .Y(n4142) );
  NAND2X0_HVT U5052 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[29]), .Y(n4140) );
  NAND2X0_HVT U5054 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[29]), .Y(n4139) );
  NAND2X0_HVT U5056 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[29]), .Y(n4138) );
  NAND2X0_HVT U5058 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[29]), .Y(n4137) );
  NAND4X0_HVT U5059 ( .A1(n4140), .A2(n4139), .A3(n4138), .A4(n4137), .Y(n4141) );
  MUX21X1_HVT U5061 ( .A1(sram_rdata[29]), .A2(n4145), .S0(n5103), .Y(n2421)
         );
  NAND2X0_HVT U5062 ( .A1(n5458), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[30]), .Y(n4149) );
  NAND2X0_HVT U5063 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[30]), .Y(n4148) );
  NAND2X0_HVT U5064 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[30]), .Y(n4147) );
  NAND4X0_HVT U5066 ( .A1(n4149), .A2(n4148), .A3(n4147), .A4(n4146), .Y(n4165) );
  NAND2X0_HVT U5067 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[30]), .Y(n4153) );
  NAND2X0_HVT U5069 ( .A1(n2791), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[30]), .Y(n4151) );
  NAND2X0_HVT U5070 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[30]), .Y(n4150) );
  NAND4X0_HVT U5071 ( .A1(n4153), .A2(n4152), .A3(n4151), .A4(n4150), .Y(n4164) );
  NAND2X0_HVT U5072 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[30]), .Y(n4157) );
  NAND2X0_HVT U5074 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[30]), .Y(n4155) );
  NAND2X0_HVT U5075 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[30]), .Y(n4154) );
  NAND4X0_HVT U5076 ( .A1(n4157), .A2(n4156), .A3(n4155), .A4(n4154), .Y(n4163) );
  NAND2X0_HVT U5077 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[30]), .Y(n4161) );
  NAND2X0_HVT U5078 ( .A1(n5426), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[30]), .Y(n4160) );
  NAND2X0_HVT U5079 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[30]), .Y(n4159) );
  NAND2X0_HVT U5080 ( .A1(n5517), .A2(n5099), .Y(n4158) );
  NAND4X0_HVT U5081 ( .A1(n4161), .A2(n4160), .A3(n4159), .A4(n4158), .Y(n4162) );
  MUX21X1_HVT U5083 ( .A1(sram_rdata[30]), .A2(n4166), .S0(n5103), .Y(n2420)
         );
  NAND2X0_HVT U5084 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[31]), .Y(n4174) );
  NAND2X0_HVT U5085 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[31]), .Y(n4173) );
  NAND2X0_HVT U5086 ( .A1(n5274), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[31]), .Y(n4172) );
  NAND2X0_HVT U5087 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[31]), .Y(n4171) );
  NAND4X0_HVT U5088 ( .A1(n4174), .A2(n4173), .A3(n4172), .A4(n4171), .Y(n4202) );
  NAND2X0_HVT U5089 ( .A1(n5518), .A2(n5096), .Y(n4182) );
  NAND2X0_HVT U5090 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[31]), .Y(n4181) );
  NAND2X0_HVT U5091 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[31]), .Y(n4180) );
  NAND4X0_HVT U5093 ( .A1(n4182), .A2(n4181), .A3(n4180), .A4(n4179), .Y(n4201) );
  NAND2X0_HVT U5094 ( .A1(n5517), .A2(n5098), .Y(n4190) );
  NAND2X0_HVT U5095 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[31]), .Y(n4189) );
  NAND2X0_HVT U5096 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[31]), .Y(n4188) );
  NAND4X0_HVT U5098 ( .A1(n4190), .A2(n4189), .A3(n4188), .A4(n4187), .Y(n4200) );
  NAND2X0_HVT U5099 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[31]), .Y(n4198) );
  NAND2X0_HVT U5100 ( .A1(n5399), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[31]), .Y(n4197) );
  NAND2X0_HVT U5101 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[31]), .Y(n4196) );
  NAND2X0_HVT U5102 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[31]), .Y(n4195) );
  NAND4X0_HVT U5103 ( .A1(n4198), .A2(n4197), .A3(n4196), .A4(n4195), .Y(n4199) );
  MUX21X1_HVT U5105 ( .A1(sram_rdata[31]), .A2(n4203), .S0(n5103), .Y(n2419)
         );
  OA222X1_HVT U5106 ( .A1(n5195), .A2(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_trans_reg_1_), .A3(n5195), .A4(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sel_reg), .A5(
        AHB_SRAM_WRAPPER_valid_trans), .A6(n4204), .Y(n2364) );
  INVX1_HVT U5107 ( .A(n4206), .Y(n4207) );
  OA21X1_HVT U5108 ( .A1(AHB_UART_WRAPPER_AHB_UART_SUB_READ_WAIT), .A2(n4207), 
        .A3(n5530), .Y(n2349) );
  MUX21X1_HVT U5109 ( .A1(AHB_UART_WRAPPER_AHB_UART_SUB_addr_reg[0]), .A2(
        n4857), .S0(n5185), .Y(n2346) );
  OA222X1_HVT U5110 ( .A1(n5194), .A2(AHB_UART_WRAPPER_AHB_UART_SUB_sel_reg), 
        .A3(n5194), .A4(AHB_UART_WRAPPER_AHB_UART_SUB_trans_reg_1_), .A5(
        AHB_UART_WRAPPER_valid_trans), .A6(n4528), .Y(n2300) );
  MUX21X1_HVT U5111 ( .A1(n5380), .A2(AHB_UART_WRAPPER_sl_addr[2]), .S0(n5194), 
        .Y(n2295) );
  INVX1_HVT U5112 ( .A(n4555), .Y(n4309) );
  NAND3X0_HVT U5113 ( .A1(n4872), .A2(n4217), .A3(n4309), .Y(n4212) );
  INVX1_HVT U5114 ( .A(n4212), .Y(n4211) );
  OA21X1_HVT U5116 ( .A1(AHB_SPI_WRAPPER_AHB_SPI_SUB_READ_WAIT), .A2(n4211), 
        .A3(n5529), .Y(n2261) );
  NAND2X0_HVT U5117 ( .A1(AHB_SPI_WRAPPER_AHB_SPI_SUB_READ_WAIT), .A2(
        AHB_SPI_WRAPPER_AHB_SPI_SUB_read_wait_counter[0]), .Y(n4214) );
  OA221X1_HVT U5118 ( .A1(AHB_SPI_WRAPPER_AHB_SPI_SUB_READ_WAIT), .A2(
        AHB_SPI_WRAPPER_AHB_SPI_SUB_read_wait_counter[0]), .A3(
        AHB_SPI_WRAPPER_AHB_SPI_SUB_READ_WAIT), .A4(n4212), .A5(n4214), .Y(
        n2260) );
  INVX1_HVT U5119 ( .A(n4214), .Y(n4215) );
  INVX1_HVT U5120 ( .A(AHB_SPI_WRAPPER_AHB_SPI_SUB_read_wait_counter[1]), .Y(
        n4213) );
  OA222X1_HVT U5121 ( .A1(n4215), .A2(
        AHB_SPI_WRAPPER_AHB_SPI_SUB_read_wait_counter[1]), .A3(n4214), .A4(
        n4213), .A5(AHB_SPI_WRAPPER_AHB_SPI_SUB_READ_WAIT), .A6(n4212), .Y(
        n2259) );
  NAND2X0_HVT U5123 ( .A1(n4872), .A2(n4217), .Y(n4218) );
  NAND2X0_HVT U5124 ( .A1(n5182), .A2(n4218), .Y(n4539) );
  OA21X1_HVT U5125 ( .A1(n5182), .A2(AHB_SPI_WRAPPER_AHB_SPI_SUB_sel_reg), 
        .A3(n4539), .Y(n2213) );
  OA222X1_HVT U5126 ( .A1(n5197), .A2(AHB_SPI_WRAPPER_AHB_SPI_SUB_sel_reg), 
        .A3(n5197), .A4(AHB_SPI_WRAPPER_AHB_SPI_SUB_trans_reg_1_), .A5(
        AHB_SPI_WRAPPER_valid_trans), .A6(n4220), .Y(n2212) );
  MUX21X1_HVT U5127 ( .A1(AHB_SPI_WRAPPER_sl_rdata[0]), .A2(spi_rdata[0]), 
        .S0(n5529), .Y(n2205) );
  MUX21X1_HVT U5128 ( .A1(AHB_SPI_WRAPPER_sl_rdata[1]), .A2(spi_rdata[1]), 
        .S0(n5529), .Y(n2204) );
  MUX21X1_HVT U5129 ( .A1(AHB_SPI_WRAPPER_sl_rdata[2]), .A2(spi_rdata[2]), 
        .S0(n2686), .Y(n2203) );
  MUX21X1_HVT U5130 ( .A1(n5267), .A2(spi_rdata[3]), .S0(n5529), .Y(n2202) );
  OA221X1_HVT U5131 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_SUBSTATE), .A2(n5531), 
        .A3(AHB_SPI_WRAPPER_SPI_CONTROLLER_SUBSTATE), .A4(n4281), .A5(n4222), 
        .Y(n2149) );
  NAND2X0_HVT U5132 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_STATE[0]), .A2(n5030), 
        .Y(n4224) );
  MUX21X1_HVT U5134 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_STATE[1]), .A2(n4550), 
        .S0(n4225), .Y(n2141) );
  AND2X2_HVT U5136 ( .A1(n5154), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_counter[0]), .Y(n4246) );
  NAND3X0_HVT U5137 ( .A1(n4305), .A2(n4301), .A3(n5031), .Y(n4284) );
  NAND2X0_HVT U5138 ( .A1(n4547), .A2(n4284), .Y(n4231) );
  NAND3X0_HVT U5139 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_STATE[1]), .A2(n4669), 
        .A3(n4227), .Y(n4228) );
  NAND2X0_HVT U5140 ( .A1(n4231), .A2(n4228), .Y(n4230) );
  OA222X1_HVT U5141 ( .A1(n5342), .A2(n4229), .A3(n5342), .A4(n4246), .A5(
        n4667), .A6(n4230), .Y(n2140) );
  OA21X1_HVT U5142 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_counter[0]), .A2(
        n4231), .A3(n4230), .Y(n2139) );
  NAND2X0_HVT U5143 ( .A1(AHB_SPI_WRAPPER_done), .A2(n5135), .Y(n4232) );
  NAND2X0_HVT U5144 ( .A1(n4233), .A2(n4232), .Y(n2131) );
  OA21X1_HVT U5145 ( .A1(n5531), .A2(n4664), .A3(n4238), .Y(n2130) );
  OA221X1_HVT U5146 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[1]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[0]), .A3(n2130), .A4(n4665), 
        .A5(n4547), .Y(n2129) );
  INVX1_HVT U5147 ( .A(n4234), .Y(n4237) );
  NAND2X0_HVT U5148 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[0]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[1]), .Y(n4236) );
  OA221X1_HVT U5149 ( .A1(n4237), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[2]), .A3(n4237), .A4(n4236), 
        .A5(n4235), .Y(n2128) );
  INVX1_HVT U5150 ( .A(n4239), .Y(n4241) );
  INVX1_HVT U5151 ( .A(AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[6]), .Y(
        n4240) );
  OA221X1_HVT U5152 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_sck_counter[6]), .A2(
        n4241), .A3(n4240), .A4(n4239), .A5(n4238), .Y(n2124) );
  NAND3X0_HVT U5153 ( .A1(n5154), .A2(n4669), .A3(n4667), .Y(n4242) );
  INVX1_HVT U5156 ( .A(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte[0]), .Y(n4248)
         );
  OAI22X1_HVT U5157 ( .A1(n4266), .A2(n4666), .A3(n4265), .A4(n4248), .Y(n2122) );
  NAND3X0_HVT U5159 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_counter[0]), .A2(
        n5154), .A3(n4667), .Y(n4243) );
  OAI22X1_HVT U5161 ( .A1(n4248), .A2(n4267), .A3(n4268), .A4(n4668), .Y(n2121) );
  NAND3X0_HVT U5163 ( .A1(n5154), .A2(n5342), .A3(n4669), .Y(n4245) );
  OAI22X1_HVT U5165 ( .A1(n4248), .A2(n4269), .A3(n4270), .A4(n4670), .Y(n2120) );
  NAND2X0_HVT U5167 ( .A1(n5342), .A2(n4246), .Y(n4247) );
  OAI22X1_HVT U5169 ( .A1(n4248), .A2(n4272), .A3(n4271), .A4(n4671), .Y(n2119) );
  NAND3X0_HVT U5171 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_bit_counter[0]), .A2(
        n5115), .A3(n4710), .Y(n4252) );
  OA21X1_HVT U5172 ( .A1(n4256), .A2(n4252), .A3(n4260), .Y(n4250) );
  MUX21X1_HVT U5173 ( .A1(n4264), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte[1]), .S0(n4250), .Y(n2118) );
  OAI22X1_HVT U5174 ( .A1(n4266), .A2(n4672), .A3(n4265), .A4(n4676), .Y(n2117) );
  OAI22X1_HVT U5175 ( .A1(n4268), .A2(n4673), .A3(n4267), .A4(n4676), .Y(n2116) );
  OAI22X1_HVT U5176 ( .A1(n4270), .A2(n4674), .A3(n4269), .A4(n4676), .Y(n2115) );
  OAI22X1_HVT U5177 ( .A1(n4272), .A2(n4676), .A3(n4271), .A4(n4675), .Y(n2114) );
  INVX1_HVT U5178 ( .A(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte[2]), .Y(n4251)
         );
  OAI22X1_HVT U5179 ( .A1(n4266), .A2(n4678), .A3(n4265), .A4(n4251), .Y(n2112) );
  OAI22X1_HVT U5180 ( .A1(n4268), .A2(n4679), .A3(n4267), .A4(n4251), .Y(n2111) );
  OAI22X1_HVT U5181 ( .A1(n4270), .A2(n4680), .A3(n4269), .A4(n4251), .Y(n2110) );
  OAI22X1_HVT U5182 ( .A1(n4272), .A2(n4251), .A3(n4271), .A4(n4681), .Y(n2109) );
  OA21X1_HVT U5183 ( .A1(n4252), .A2(n4262), .A3(n4260), .Y(n4253) );
  MUX21X1_HVT U5184 ( .A1(n4264), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte[3]), .S0(n4253), .Y(n2108) );
  OAI22X1_HVT U5185 ( .A1(n4266), .A2(n4682), .A3(n4265), .A4(n4686), .Y(n2107) );
  OAI22X1_HVT U5186 ( .A1(n4268), .A2(n4683), .A3(n4267), .A4(n4686), .Y(n2106) );
  OAI22X1_HVT U5187 ( .A1(n4270), .A2(n4684), .A3(n4269), .A4(n4686), .Y(n2105) );
  OAI22X1_HVT U5188 ( .A1(n4272), .A2(n4686), .A3(n4271), .A4(n4685), .Y(n2104) );
  NAND3X0_HVT U5189 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_bit_counter[2]), .A2(
        n5115), .A3(n5430), .Y(n4258) );
  OA21X1_HVT U5190 ( .A1(n4256), .A2(n4258), .A3(n4260), .Y(n4254) );
  MUX21X1_HVT U5191 ( .A1(n4264), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte[4]), .S0(n4254), .Y(n2103) );
  OAI22X1_HVT U5192 ( .A1(n4266), .A2(n4687), .A3(n4265), .A4(n4691), .Y(n2102) );
  OAI22X1_HVT U5193 ( .A1(n4268), .A2(n4688), .A3(n4267), .A4(n4691), .Y(n2101) );
  OAI22X1_HVT U5194 ( .A1(n4270), .A2(n4689), .A3(n4269), .A4(n4691), .Y(n2100) );
  OAI22X1_HVT U5195 ( .A1(n4272), .A2(n4691), .A3(n4271), .A4(n4690), .Y(n2099) );
  NAND3X0_HVT U5196 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_bit_counter[0]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_bit_counter[2]), .A3(n5115), .Y(n4261)
         );
  OA21X1_HVT U5197 ( .A1(n4256), .A2(n4261), .A3(n4260), .Y(n4257) );
  MUX21X1_HVT U5198 ( .A1(n4264), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte[5]), .S0(n4257), .Y(n2098) );
  OAI22X1_HVT U5199 ( .A1(n4266), .A2(n4692), .A3(n4265), .A4(n4696), .Y(n2097) );
  OAI22X1_HVT U5200 ( .A1(n4268), .A2(n4693), .A3(n4267), .A4(n4696), .Y(n2096) );
  OAI22X1_HVT U5201 ( .A1(n4270), .A2(n4694), .A3(n4269), .A4(n4696), .Y(n2095) );
  OAI22X1_HVT U5202 ( .A1(n4272), .A2(n4696), .A3(n4271), .A4(n4695), .Y(n2094) );
  OA21X1_HVT U5203 ( .A1(n4262), .A2(n4258), .A3(n4260), .Y(n4259) );
  MUX21X1_HVT U5204 ( .A1(n4264), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte[6]), .S0(n4259), .Y(n2093) );
  OAI22X1_HVT U5205 ( .A1(n4266), .A2(n4697), .A3(n4265), .A4(n4701), .Y(n2092) );
  OAI22X1_HVT U5206 ( .A1(n4268), .A2(n4698), .A3(n4267), .A4(n4701), .Y(n2091) );
  OAI22X1_HVT U5207 ( .A1(n4270), .A2(n4699), .A3(n4269), .A4(n4701), .Y(n2090) );
  OAI22X1_HVT U5208 ( .A1(n4272), .A2(n4701), .A3(n4271), .A4(n4700), .Y(n2089) );
  OA21X1_HVT U5209 ( .A1(n4262), .A2(n4261), .A3(n4260), .Y(n4263) );
  MUX21X1_HVT U5210 ( .A1(n4264), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte[7]), .S0(n4263), .Y(n2088) );
  OAI22X1_HVT U5211 ( .A1(n4266), .A2(n4702), .A3(n4265), .A4(n4706), .Y(n2087) );
  OAI22X1_HVT U5212 ( .A1(n4268), .A2(n4703), .A3(n4267), .A4(n4706), .Y(n2086) );
  OAI22X1_HVT U5213 ( .A1(n4270), .A2(n4704), .A3(n4269), .A4(n4706), .Y(n2085) );
  OAI22X1_HVT U5214 ( .A1(n4272), .A2(n4706), .A3(n4271), .A4(n4705), .Y(n2084) );
  AND2X1_HVT U5215 ( .A1(n4709), .A2(n4708), .Y(n4273) );
  OA221X1_HVT U5216 ( .A1(n5031), .A2(n4305), .A3(n5031), .A4(n4301), .A5(
        n5030), .Y(n4275) );
  OAI22X1_HVT U5217 ( .A1(n4274), .A2(n4273), .A3(n4275), .A4(n4708), .Y(n2083) );
  INVX1_HVT U5218 ( .A(n4275), .Y(n4285) );
  OA221X1_HVT U5219 ( .A1(n4709), .A2(n4285), .A3(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter[0]), .A4(n4277), .A5(n4276), 
        .Y(n2082) );
  NAND2X0_HVT U5220 ( .A1(n4301), .A2(n4281), .Y(n4278) );
  NAND2X0_HVT U5221 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_bit_counter[0]), .A2(
        n4278), .Y(n4279) );
  NAND3X0_HVT U5222 ( .A1(n4301), .A2(n5430), .A3(n4281), .Y(n4280) );
  NAND3X0_HVT U5223 ( .A1(n4279), .A2(n4547), .A3(n4280), .Y(n2081) );
  NAND2X0_HVT U5224 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_bit_counter[1]), .A2(
        n4280), .Y(n4282) );
  NAND4X0_HVT U5225 ( .A1(n4301), .A2(n5430), .A3(n4707), .A4(n4281), .Y(n4283) );
  NAND3X0_HVT U5226 ( .A1(n4282), .A2(n4547), .A3(n4283), .Y(n2080) );
  NAND2X0_HVT U5227 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_bit_counter[2]), .A2(
        n4283), .Y(n4286) );
  NAND3X0_HVT U5228 ( .A1(n4286), .A2(n4285), .A3(n4284), .Y(n2079) );
  NAND2X0_HVT U5229 ( .A1(n4711), .A2(n4710), .Y(n4289) );
  NAND2X0_HVT U5230 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte[0]), .A2(
        n4710), .Y(n4288) );
  NAND3X0_HVT U5231 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_bit_counter[0]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_bit_counter[2]), .A3(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte[4]), .Y(n4287) );
  NAND4X0_HVT U5232 ( .A1(n4289), .A2(n4707), .A3(n4288), .A4(n4287), .Y(n4298) );
  OA221X1_HVT U5233 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter[0]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[23]), .A3(n4709), .A4(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[15]), .A5(n4708), .Y(n4296) );
  NAND2X0_HVT U5234 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter[1]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_shift[7]), .Y(n4290) );
  NAND2X0_HVT U5235 ( .A1(n4305), .A2(n4290), .Y(n4295) );
  OA221X1_HVT U5236 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_bit_counter[0]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte[1]), .A3(n4711), .A4(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte[2]), .A5(n4710), .Y(n4294) );
  NAND3X0_HVT U5237 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_bit_counter[2]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte[5]), .A3(n4711), .Y(n4292) );
  NAND3X0_HVT U5238 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_bit_counter[0]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_bit_counter[2]), .A3(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte[6]), .Y(n4291) );
  NAND3X0_HVT U5239 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_bit_counter[1]), .A2(
        n4292), .A3(n4291), .Y(n4293) );
  OA22X1_HVT U5240 ( .A1(n4296), .A2(n4295), .A3(n4294), .A4(n4293), .Y(n4297)
         );
  OA221X1_HVT U5241 ( .A1(n4298), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_byte[3]), .A3(n4298), .A4(n5430), 
        .A5(n4297), .Y(n4299) );
  NAND3X0_HVT U5243 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_STATE[0]), .A2(n4301), 
        .A3(n5030), .Y(n4306) );
  INVX1_HVT U5244 ( .A(n4302), .Y(n4304) );
  MUX21X1_HVT U5246 ( .A1(n4308), .A2(SPI_MOSI), .S0(n4307), .Y(n2078) );
  NAND2X0_HVT U5247 ( .A1(n4309), .A2(n4317), .Y(n4312) );
  INVX1_HVT U5248 ( .A(n4312), .Y(n4311) );
  OA21X1_HVT U5250 ( .A1(AHB_I2C_WRAPPER_AHB_I2C_SUB_READ_WAIT), .A2(n4311), 
        .A3(n5532), .Y(n2076) );
  NAND2X0_HVT U5251 ( .A1(AHB_I2C_WRAPPER_AHB_I2C_SUB_READ_WAIT), .A2(
        AHB_I2C_WRAPPER_AHB_I2C_SUB_read_wait_counter[0]), .Y(n4314) );
  OA221X1_HVT U5252 ( .A1(AHB_I2C_WRAPPER_AHB_I2C_SUB_READ_WAIT), .A2(
        AHB_I2C_WRAPPER_AHB_I2C_SUB_read_wait_counter[0]), .A3(
        AHB_I2C_WRAPPER_AHB_I2C_SUB_READ_WAIT), .A4(n4312), .A5(n4314), .Y(
        n2075) );
  INVX1_HVT U5253 ( .A(n4314), .Y(n4315) );
  INVX1_HVT U5254 ( .A(AHB_I2C_WRAPPER_AHB_I2C_SUB_read_wait_counter[1]), .Y(
        n4313) );
  OA222X1_HVT U5255 ( .A1(n4315), .A2(
        AHB_I2C_WRAPPER_AHB_I2C_SUB_read_wait_counter[1]), .A3(n4314), .A4(
        n4313), .A5(AHB_I2C_WRAPPER_AHB_I2C_SUB_READ_WAIT), .A6(n4312), .Y(
        n2074) );
  INVX1_HVT U5257 ( .A(n4317), .Y(n4318) );
  NAND2X0_HVT U5258 ( .A1(n5187), .A2(n4318), .Y(n4561) );
  OA21X1_HVT U5259 ( .A1(n5187), .A2(AHB_I2C_WRAPPER_AHB_I2C_SUB_sel_reg), 
        .A3(n4561), .Y(n2028) );
  OA222X1_HVT U5260 ( .A1(n5196), .A2(AHB_I2C_WRAPPER_AHB_I2C_SUB_trans_reg_1_), .A3(n5196), .A4(AHB_I2C_WRAPPER_AHB_I2C_SUB_sel_reg), .A5(
        AHB_I2C_WRAPPER_valid_trans), .A6(n4320), .Y(n2027) );
  MUX21X1_HVT U5261 ( .A1(AHB_I2C_WRAPPER_sl_rdata[0]), .A2(i2c_rdata[0]), 
        .S0(n5532), .Y(n2020) );
  MUX21X1_HVT U5262 ( .A1(AHB_I2C_WRAPPER_sl_rdata[1]), .A2(i2c_rdata[1]), 
        .S0(n5532), .Y(n2019) );
  MUX21X1_HVT U5263 ( .A1(AHB_I2C_WRAPPER_sl_rdata[2]), .A2(i2c_rdata[2]), 
        .S0(n5532), .Y(n2018) );
  MUX21X1_HVT U5264 ( .A1(n5345), .A2(i2c_rdata[3]), .S0(n5532), .Y(n2017) );
  OAI22X1_HVT U5265 ( .A1(n5176), .A2(n4721), .A3(n5519), .A4(n4322), .Y(n1963) );
  OAI22X1_HVT U5266 ( .A1(n5176), .A2(n4722), .A3(n5519), .A4(n4323), .Y(n1961) );
  OAI22X1_HVT U5267 ( .A1(n5172), .A2(n4723), .A3(n5519), .A4(n4324), .Y(n1960) );
  MUX21X1_HVT U5268 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_size[2]), .A2(
        AHB_I2C_WRAPPER_rx_byte_size[2]), .S0(n5174), .Y(n1955) );
  AND2X1_HVT U5270 ( .A1(n4331), .A2(n4713), .Y(n4326) );
  NAND2X0_HVT U5272 ( .A1(n4719), .A2(n5381), .Y(n4386) );
  NAND2X0_HVT U5273 ( .A1(n4386), .A2(n4374), .Y(n4329) );
  NAND2X0_HVT U5274 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[2]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[1]), .Y(n4328) );
  NAND3X0_HVT U5275 ( .A1(n4329), .A2(n5156), .A3(n4328), .Y(n4330) );
  NAND2X0_HVT U5276 ( .A1(n4341), .A2(n4728), .Y(n4441) );
  INVX1_HVT U5277 ( .A(n4441), .Y(n4367) );
  OA21X1_HVT U5279 ( .A1(n4368), .A2(n4372), .A3(n4331), .Y(n4343) );
  NAND2X0_HVT U5281 ( .A1(n5108), .A2(n5381), .Y(n4381) );
  NAND2X0_HVT U5282 ( .A1(n3462), .A2(n4381), .Y(n4338) );
  NAND2X0_HVT U5283 ( .A1(n4726), .A2(n4338), .Y(n4334) );
  OAI222X1_HVT U5285 ( .A1(n4344), .A2(n4343), .A3(n4344), .A4(n4334), .A5(
        n4726), .A6(n5191), .Y(n1952) );
  NAND3X0_HVT U5286 ( .A1(n4338), .A2(n5394), .A3(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_bit_counter[0]), .Y(n4337) );
  NAND2X0_HVT U5287 ( .A1(n4341), .A2(n4338), .Y(n4335) );
  OA222X1_HVT U5288 ( .A1(n4344), .A2(n4343), .A3(n4344), .A4(n4335), .A5(
        n4727), .A6(n5191), .Y(n4336) );
  NAND2X0_HVT U5289 ( .A1(n4337), .A2(n4336), .Y(n1951) );
  INVX1_HVT U5290 ( .A(n4338), .Y(n4340) );
  OA21X1_HVT U5291 ( .A1(n4341), .A2(n4340), .A3(n5191), .Y(n4342) );
  OAI22X1_HVT U5292 ( .A1(n4344), .A2(n4343), .A3(n4342), .A4(n4728), .Y(n1950) );
  NAND2X0_HVT U5293 ( .A1(n4714), .A2(n4345), .Y(n4348) );
  OA221X1_HVT U5294 ( .A1(n4348), .A2(n5120), .A3(n4348), .A4(n5505), .A5(
        n4346), .Y(n1948) );
  OA221X1_HVT U5295 ( .A1(n4350), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[2]), .A3(n4349), .A4(n4715), 
        .A5(n4356), .Y(n1946) );
  OA221X1_HVT U5296 ( .A1(n4352), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[4]), .A3(n4351), .A4(n4716), 
        .A5(n4356), .Y(n1944) );
  INVX1_HVT U5297 ( .A(n4354), .Y(n4355) );
  OA221X1_HVT U5298 ( .A1(n4355), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[7]), .A3(n4354), .A4(n4717), 
        .A5(n4356), .Y(n1941) );
  OA222X1_HVT U5299 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[8]), .A2(
        n4355), .A3(AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[8]), .A4(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_scl_counter[7]), .A5(n4354), .A6(n4353), 
        .Y(n4357) );
  AND2X1_HVT U5300 ( .A1(n4357), .A2(n4356), .Y(n1940) );
  MUX21X1_HVT U5301 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_size[0]), .A2(
        AHB_I2C_WRAPPER_tx_byte_size[0]), .S0(n5178), .Y(n1939) );
  MUX21X1_HVT U5302 ( .A1(n5340), .A2(AHB_I2C_WRAPPER_tx_byte_size[1]), .S0(
        n5178), .Y(n1938) );
  MUX21X1_HVT U5303 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_size[2]), .A2(
        AHB_I2C_WRAPPER_tx_byte_size[2]), .S0(n5172), .Y(n1937) );
  NAND3X0_HVT U5304 ( .A1(n4361), .A2(n4360), .A3(n5281), .Y(n4363) );
  INVX1_HVT U5305 ( .A(n4363), .Y(n4362) );
  OA221X1_HVT U5306 ( .A1(n5018), .A2(n4363), .A3(n4362), .A4(n5454), .A5(
        n5175), .Y(n1936) );
  OA221X1_HVT U5307 ( .A1(n4365), .A2(n5388), .A3(n4365), .A4(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_rw_mode), .A5(n5017), .Y(n4378) );
  OA21X1_HVT U5308 ( .A1(n4390), .A2(n4370), .A3(n5131), .Y(n4392) );
  OA21X1_HVT U5309 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[2]), .A2(n4367), 
        .A3(n5156), .Y(n4369) );
  OAI22X1_HVT U5310 ( .A1(n4369), .A2(n5381), .A3(AHB_I2C_WRAPPER_i2c_start), 
        .A4(n4368), .Y(n4373) );
  OA222X1_HVT U5311 ( .A1(n4370), .A2(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[2]), 
        .A3(n4370), .A4(n4441), .A5(n5016), .A6(n5381), .Y(n4371) );
  OA22X1_HVT U5312 ( .A1(n4374), .A2(n4373), .A3(n4372), .A4(n4371), .Y(n4375)
         );
  NAND2X0_HVT U5313 ( .A1(n4392), .A2(n4375), .Y(n4387) );
  NAND2X0_HVT U5314 ( .A1(n4376), .A2(n4387), .Y(n4377) );
  OA22X1_HVT U5315 ( .A1(n4378), .A2(n4377), .A3(n5505), .A4(n4387), .Y(n1935)
         );
  NAND4X0_HVT U5317 ( .A1(n5119), .A2(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[2]), 
        .A3(n4384), .A4(n5167), .Y(n4382) );
  NAND3X0_HVT U5318 ( .A1(n546), .A2(n4382), .A3(n4381), .Y(n4383) );
  INVX1_HVT U5319 ( .A(n4387), .Y(n4395) );
  MUX21X1_HVT U5320 ( .A1(n4383), .A2(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[1]), 
        .S0(n4395), .Y(n1934) );
  OA221X1_HVT U5321 ( .A1(n4386), .A2(n5017), .A3(n4386), .A4(n4384), .A5(
        n4397), .Y(n4388) );
  OAI222X1_HVT U5322 ( .A1(n5016), .A2(n4388), .A3(n5016), .A4(n4387), .A5(
        n4395), .A6(n506), .Y(n1933) );
  OA22X1_HVT U5323 ( .A1(n4406), .A2(n4398), .A3(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_rw_mode), .A4(n4389), .Y(n4391) );
  AND3X1_HVT U5324 ( .A1(n497), .A2(n4391), .A3(n4390), .Y(n4394) );
  INVX1_HVT U5325 ( .A(n4392), .Y(n4393) );
  OAI22X1_HVT U5326 ( .A1(n4395), .A2(n4394), .A3(n4719), .A4(n4393), .Y(n1932) );
  OA21X1_HVT U5327 ( .A1(n5168), .A2(n4397), .A3(n5506), .Y(n4400) );
  OA221X1_HVT U5329 ( .A1(n4400), .A2(n4725), .A3(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_counter[0]), .A4(n5127), .A5(n5498), 
        .Y(n1930) );
  NAND2X0_HVT U5331 ( .A1(n5127), .A2(n4725), .Y(n4402) );
  OA221X1_HVT U5332 ( .A1(n5132), .A2(n4404), .A3(n5132), .A4(n5169), .A5(
        n4402), .Y(n4408) );
  OAI22X1_HVT U5335 ( .A1(n4408), .A2(n5285), .A3(n5130), .A4(n4447), .Y(n1929) );
  OA21X1_HVT U5336 ( .A1(n4411), .A2(n4410), .A3(n5180), .Y(n4414) );
  OA221X1_HVT U5337 ( .A1(n4414), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_counter[1]), .A3(n4414), .A4(n4413), 
        .A5(n4412), .Y(n1926) );
  NAND2X0_HVT U5338 ( .A1(n5117), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[8]), .Y(n4420) );
  NAND2X0_HVT U5339 ( .A1(n5118), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[16]), .Y(n4419) );
  NAND2X0_HVT U5340 ( .A1(n5116), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[0]), .Y(n4418) );
  NAND4X0_HVT U5341 ( .A1(n5167), .A2(n4420), .A3(n4419), .A4(n4418), .Y(n4423) );
  OA222X1_HVT U5343 ( .A1(n5198), .A2(n4424), .A3(n5198), .A4(n4423), .A5(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[0]), .A6(n5199), .Y(n1925) );
  NAND3X0_HVT U5344 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_bit_counter[0]), .A2(
        n5394), .A3(n4430), .Y(n4432) );
  OA21X1_HVT U5345 ( .A1(n4728), .A2(n4432), .A3(n5171), .Y(n4426) );
  MUX21X1_HVT U5346 ( .A1(n4443), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[7]), .S0(n4426), .Y(n1917) );
  OA221X1_HVT U5349 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[7]), .A2(
        n4445), .A3(n5152), .A4(AHB_I2C_WRAPPER_rx_data[31]), .A5(n5177), .Y(
        n1916) );
  OA221X1_HVT U5352 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[7]), .A2(
        n4447), .A3(n5153), .A4(AHB_I2C_WRAPPER_rx_data[23]), .A5(n5177), .Y(
        n1915) );
  OA221X1_HVT U5355 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[7]), .A2(
        n4449), .A3(n5151), .A4(AHB_I2C_WRAPPER_rx_data[15]), .A5(n5177), .Y(
        n1914) );
  OA221X1_HVT U5358 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[7]), .A2(
        n4452), .A3(n5150), .A4(AHB_I2C_WRAPPER_rx_data[7]), .A5(n5177), .Y(
        n1913) );
  NAND3X0_HVT U5359 ( .A1(n5394), .A2(n4430), .A3(n4726), .Y(n4434) );
  OA21X1_HVT U5360 ( .A1(n4728), .A2(n4434), .A3(n5171), .Y(n4429) );
  MUX21X1_HVT U5361 ( .A1(n4443), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[6]), .S0(n4429), .Y(n1912) );
  OA221X1_HVT U5362 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[6]), .A2(
        n4445), .A3(n5152), .A4(AHB_I2C_WRAPPER_rx_data[30]), .A5(n5177), .Y(
        n1911) );
  OA221X1_HVT U5363 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[6]), .A2(
        n4447), .A3(n5153), .A4(AHB_I2C_WRAPPER_rx_data[22]), .A5(n5177), .Y(
        n1910) );
  OA221X1_HVT U5364 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[6]), .A2(
        n4449), .A3(n5151), .A4(AHB_I2C_WRAPPER_rx_data[14]), .A5(n5177), .Y(
        n1909) );
  OA221X1_HVT U5365 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[6]), .A2(
        n4452), .A3(n5150), .A4(AHB_I2C_WRAPPER_rx_data[6]), .A5(n5177), .Y(
        n1908) );
  NAND3X0_HVT U5366 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_bit_counter[0]), .A2(
        n4430), .A3(n4727), .Y(n4436) );
  OA21X1_HVT U5367 ( .A1(n4728), .A2(n4436), .A3(n5171), .Y(n4431) );
  MUX21X1_HVT U5368 ( .A1(n4443), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[5]), .S0(n4431), .Y(n1907) );
  OA221X1_HVT U5369 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[5]), .A2(
        n4445), .A3(n5152), .A4(AHB_I2C_WRAPPER_rx_data[29]), .A5(n5177), .Y(
        n1906) );
  OA221X1_HVT U5370 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[5]), .A2(
        n4447), .A3(n5153), .A4(AHB_I2C_WRAPPER_rx_data[21]), .A5(n5177), .Y(
        n1905) );
  OA221X1_HVT U5371 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[5]), .A2(
        n4449), .A3(n5151), .A4(AHB_I2C_WRAPPER_rx_data[13]), .A5(n5177), .Y(
        n1904) );
  OA221X1_HVT U5372 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[5]), .A2(
        n4452), .A3(n5150), .A4(AHB_I2C_WRAPPER_rx_data[5]), .A5(n5177), .Y(
        n1903) );
  OA221X1_HVT U5373 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[4]), .A2(
        n4445), .A3(n5152), .A4(AHB_I2C_WRAPPER_rx_data[28]), .A5(n5177), .Y(
        n1901) );
  OA221X1_HVT U5374 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[4]), .A2(
        n4447), .A3(n5153), .A4(AHB_I2C_WRAPPER_rx_data[20]), .A5(n5177), .Y(
        n1900) );
  OA221X1_HVT U5375 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[4]), .A2(
        n4449), .A3(n5151), .A4(AHB_I2C_WRAPPER_rx_data[12]), .A5(n5177), .Y(
        n1899) );
  OA221X1_HVT U5376 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[4]), .A2(
        n4452), .A3(n5150), .A4(AHB_I2C_WRAPPER_rx_data[4]), .A5(n5177), .Y(
        n1898) );
  OA21X1_HVT U5377 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_bit_counter[2]), .A2(
        n4432), .A3(n5171), .Y(n4433) );
  MUX21X1_HVT U5378 ( .A1(n4443), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[3]), .S0(n4433), .Y(n1897) );
  OA221X1_HVT U5379 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[3]), .A2(
        n4445), .A3(n5152), .A4(AHB_I2C_WRAPPER_rx_data[27]), .A5(n5177), .Y(
        n1896) );
  OA221X1_HVT U5380 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[3]), .A2(
        n4447), .A3(n5153), .A4(AHB_I2C_WRAPPER_rx_data[19]), .A5(n5177), .Y(
        n1895) );
  OA221X1_HVT U5381 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[3]), .A2(
        n4449), .A3(n5151), .A4(AHB_I2C_WRAPPER_rx_data[11]), .A5(n5177), .Y(
        n1894) );
  OA221X1_HVT U5382 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[3]), .A2(
        n4452), .A3(n5150), .A4(AHB_I2C_WRAPPER_rx_data[3]), .A5(n5177), .Y(
        n1893) );
  OA21X1_HVT U5383 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_bit_counter[2]), .A2(
        n4434), .A3(n5171), .Y(n4435) );
  MUX21X1_HVT U5384 ( .A1(n4443), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[2]), .S0(n4435), .Y(n1892) );
  OA221X1_HVT U5385 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[2]), .A2(
        n4445), .A3(n5152), .A4(AHB_I2C_WRAPPER_rx_data[26]), .A5(n5177), .Y(
        n1891) );
  OA221X1_HVT U5386 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[2]), .A2(
        n4447), .A3(n5153), .A4(AHB_I2C_WRAPPER_rx_data[18]), .A5(n5177), .Y(
        n1890) );
  OA221X1_HVT U5387 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[2]), .A2(
        n4449), .A3(n5151), .A4(AHB_I2C_WRAPPER_rx_data[10]), .A5(n5171), .Y(
        n1889) );
  OA221X1_HVT U5388 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[2]), .A2(
        n4452), .A3(n5150), .A4(AHB_I2C_WRAPPER_rx_data[2]), .A5(n5177), .Y(
        n1888) );
  OA21X1_HVT U5389 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_bit_counter[2]), .A2(
        n4436), .A3(n5171), .Y(n4437) );
  MUX21X1_HVT U5390 ( .A1(n4443), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[1]), .S0(n4437), .Y(n1887) );
  OA221X1_HVT U5391 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[1]), .A2(
        n4445), .A3(n5152), .A4(AHB_I2C_WRAPPER_rx_data[25]), .A5(n5177), .Y(
        n1886) );
  OA221X1_HVT U5392 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[1]), .A2(
        n4447), .A3(n5153), .A4(AHB_I2C_WRAPPER_rx_data[17]), .A5(n5171), .Y(
        n1885) );
  OA221X1_HVT U5393 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[1]), .A2(
        n4449), .A3(n5151), .A4(AHB_I2C_WRAPPER_rx_data[9]), .A5(n5171), .Y(
        n1884) );
  OA221X1_HVT U5394 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[1]), .A2(
        n4452), .A3(n5150), .A4(AHB_I2C_WRAPPER_rx_data[1]), .A5(n5177), .Y(
        n1883) );
  OA21X1_HVT U5395 ( .A1(n4441), .A2(n4440), .A3(n5171), .Y(n4442) );
  MUX21X1_HVT U5396 ( .A1(n4443), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[0]), .S0(n4442), .Y(n1882) );
  OA221X1_HVT U5397 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[0]), .A2(
        n4445), .A3(n5152), .A4(AHB_I2C_WRAPPER_rx_data[24]), .A5(n5177), .Y(
        n1881) );
  OA221X1_HVT U5398 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[0]), .A2(
        n4447), .A3(n5153), .A4(AHB_I2C_WRAPPER_rx_data[16]), .A5(n5177), .Y(
        n1880) );
  OA221X1_HVT U5399 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[0]), .A2(
        n4449), .A3(n5151), .A4(AHB_I2C_WRAPPER_rx_data[8]), .A5(n5171), .Y(
        n1879) );
  OA221X1_HVT U5400 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[0]), .A2(
        n4452), .A3(n5150), .A4(AHB_I2C_WRAPPER_rx_data[0]), .A5(n5177), .Y(
        n1878) );
  NAND4X0_HVT U5402 ( .A1(n5509), .A2(n5470), .A3(n5370), .A4(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_STATE[1]), .Y(n4453) );
  NAND2X0_HVT U5403 ( .A1(n4730), .A2(n4453), .Y(n4454) );
  NAND2X0_HVT U5404 ( .A1(AHB_UART_WRAPPER_UART_CONTROLLER_Txclk_en), .A2(
        n4454), .Y(n4455) );
  NAND2X0_HVT U5405 ( .A1(n5137), .A2(n4455), .Y(n4459) );
  OA221X1_HVT U5406 ( .A1(n4741), .A2(n4729), .A3(n4741), .A4(n5524), .A5(
        n4459), .Y(n4456) );
  OA21X1_HVT U5407 ( .A1(AHB_UART_WRAPPER_UART_CONTROLLER_Txclk_en), .A2(n5371), .A3(AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_STATE[0]), .Y(n4458) );
  INVX1_HVT U5408 ( .A(n4458), .Y(n4457) );
  OA21X1_HVT U5409 ( .A1(AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_STATE[0]), .A2(n4456), .A3(n4457), .Y(n1876) );
  OA221X1_HVT U5410 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_STATE[1]), .A2(n4458), 
        .A3(n4729), .A4(n4457), .A5(n4741), .Y(n1875) );
  AND4X1_HVT U5411 ( .A1(AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_STATE[0]), .A2(AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_STATE[1]), .A3(n4741), .A4(
        n4459), .Y(n1874) );
  AND2X1_HVT U5412 ( .A1(n5488), .A2(n5111), .Y(n4461) );
  NAND2X0_HVT U5413 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_STATE[1]), .A2(n4730), 
        .Y(n4460) );
  OAI22X1_HVT U5414 ( .A1(n5137), .A2(n4461), .A3(n4731), .A4(n4460), .Y(n4465) );
  AND3X1_HVT U5415 ( .A1(AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_STATE[1]), .A2(n4465), .A3(n4741), .Y(n4468) );
  NAND2X0_HVT U5416 ( .A1(n5509), .A2(n4465), .Y(n4463) );
  OA21X1_HVT U5417 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Bit_Counter[0]), .A2(
        n4468), .A3(n4463), .Y(n1873) );
  NAND2X0_HVT U5418 ( .A1(n5509), .A2(n5470), .Y(n4466) );
  NAND3X0_HVT U5419 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_STATE[1]), .A2(n4466), 
        .A3(n4741), .Y(n4464) );
  NAND2X0_HVT U5420 ( .A1(n4465), .A2(n4464), .Y(n4467) );
  OA221X1_HVT U5421 ( .A1(n5470), .A2(n5509), .A3(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Bit_Counter[1]), .A4(
        n4465), .A5(n4467), .Y(n1872) );
  INVX1_HVT U5422 ( .A(n4466), .Y(n4469) );
  OA222X1_HVT U5423 ( .A1(n5370), .A2(n4469), .A3(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Bit_Counter[2]), .A4(
        n4468), .A5(n4742), .A6(n4467), .Y(n1871) );
  AND2X1_HVT U5424 ( .A1(n5371), .A2(n4470), .Y(n4476) );
  NAND2X0_HVT U5425 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter[0]), .A2(
        n5013), .Y(n4581) );
  NAND3X0_HVT U5426 ( .A1(n5111), .A2(n5488), .A3(n5524), .Y(n4474) );
  OAI22X1_HVT U5427 ( .A1(n4476), .A2(n5013), .A3(n4581), .A4(n4474), .Y(n1870) );
  NAND2X0_HVT U5428 ( .A1(n4477), .A2(n4738), .Y(n4478) );
  OAI22X1_HVT U5429 ( .A1(n4479), .A2(n4478), .A3(n4477), .A4(n4738), .Y(n1867) );
  NAND2X0_HVT U5430 ( .A1(n4500), .A2(n4735), .Y(n4498) );
  OR3X1_HVT U5431 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[2]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[1]), .A3(
        n4498), .Y(n4480) );
  MUX21X1_HVT U5432 ( .A1(n4816), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[0]), .S0(n4480), .Y(n1866) );
  OR3X1_HVT U5433 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[1]), .A2(
        n4733), .A3(n4498), .Y(n4481) );
  MUX21X1_HVT U5434 ( .A1(n4816), .A2(n5406), .S0(n4481), .Y(n1862) );
  NAND2X0_HVT U5436 ( .A1(n5012), .A2(n5010), .Y(n4505) );
  INVX1_HVT U5437 ( .A(n4505), .Y(n4489) );
  OA21X1_HVT U5439 ( .A1(n4816), .A2(n5201), .A3(n4489), .Y(n4488) );
  INVX1_HVT U5441 ( .A(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter[3]), .Y(
        n4484) );
  NAND4X0_HVT U5442 ( .A1(AHB_UART_WRAPPER_UART_CONTROLLER_Rxclk_en), .A2(
        n5011), .A3(n4521), .A4(n4484), .Y(n4487) );
  AND4X1_HVT U5443 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter[0]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter[1]), .A3(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter[2]), .A4(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter[3]), .Y(
        n4496) );
  NAND3X0_HVT U5444 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[2]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[1]), .A3(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[0]), .Y(n4485) );
  NAND2X0_HVT U5445 ( .A1(n5012), .A2(n4485), .Y(n4486) );
  NAND4X0_HVT U5446 ( .A1(AHB_UART_WRAPPER_UART_CONTROLLER_Rxclk_en), .A2(
        n5499), .A3(n4496), .A4(n4486), .Y(n4490) );
  OAI221X1_HVT U5447 ( .A1(n4488), .A2(n4513), .A3(n4488), .A4(n4487), .A5(
        n4490), .Y(n4492) );
  MUX21X1_HVT U5448 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_STATE[0]), .A2(n4489), 
        .S0(n4492), .Y(n1858) );
  AND2X1_HVT U5449 ( .A1(n4490), .A2(n5499), .Y(n4506) );
  OAI21X1_HVT U5450 ( .A1(n5499), .A2(n4816), .A3(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_STATE[0]), .Y(n4491) );
  OA221X1_HVT U5451 ( .A1(n4506), .A2(n4491), .A3(n4506), .A4(n4492), .A5(
        n4513), .Y(n1857) );
  AND2X1_HVT U5452 ( .A1(n5499), .A2(n5010), .Y(n4493) );
  AND4X1_HVT U5453 ( .A1(n4816), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_STATE[0]), .A3(n4493), 
        .A4(n4492), .Y(n1856) );
  NAND3X0_HVT U5454 ( .A1(AHB_UART_WRAPPER_UART_CONTROLLER_Rxclk_en), .A2(
        n5499), .A3(n5010), .Y(n4517) );
  NAND3X0_HVT U5455 ( .A1(n5011), .A2(n5012), .A3(n5010), .Y(n4509) );
  NAND2X0_HVT U5456 ( .A1(AHB_UART_WRAPPER_UART_CONTROLLER_Rxclk_en), .A2(
        n5010), .Y(n4511) );
  NAND2X0_HVT U5457 ( .A1(n4509), .A2(n4511), .Y(n4515) );
  OA221X1_HVT U5458 ( .A1(n4496), .A2(n5012), .A3(n4496), .A4(n4517), .A5(
        n4515), .Y(n4518) );
  NAND2X0_HVT U5459 ( .A1(n4518), .A2(n5012), .Y(n4499) );
  NAND2X0_HVT U5460 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[0]), .A2(
        n4499), .Y(n4497) );
  NAND2X0_HVT U5461 ( .A1(n4498), .A2(n4497), .Y(n1855) );
  NAND2X0_HVT U5462 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[1]), .A2(
        n4499), .Y(n4503) );
  NAND3X0_HVT U5463 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[0]), .A2(
        n4500), .A3(n4734), .Y(n4502) );
  NAND3X0_HVT U5464 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[1]), .A2(
        n4500), .A3(n4735), .Y(n4501) );
  NAND3X0_HVT U5465 ( .A1(n4503), .A2(n4502), .A3(n4501), .Y(n1854) );
  AND4X1_HVT U5466 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[0]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[1]), .A3(
        n4518), .A4(n5012), .Y(n4507) );
  OA22X1_HVT U5467 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[2]), .A2(
        n4507), .A3(n4506), .A4(n4505), .Y(n1853) );
  NAND2X0_HVT U5468 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter[0]), .A2(
        n4515), .Y(n4508) );
  OA221X1_HVT U5469 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter[0]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_Rxclk_en), .A3(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter[0]), .A4(
        n4513), .A5(n4508), .Y(n1852) );
  NAND2X0_HVT U5470 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter[0]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter[1]), .Y(
        n4512) );
  OA221X1_HVT U5471 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter[1]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter[0]), .A3(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter[1]), .A4(
        n4515), .A5(n4509), .Y(n4510) );
  OA21X1_HVT U5472 ( .A1(n4512), .A2(n4511), .A3(n4510), .Y(n1851) );
  NAND2X0_HVT U5473 ( .A1(n4736), .A2(n4512), .Y(n4514) );
  NAND3X0_HVT U5474 ( .A1(n4514), .A2(n4513), .A3(
        AHB_UART_WRAPPER_UART_CONTROLLER_Rxclk_en), .Y(n4516) );
  OAI22X1_HVT U5475 ( .A1(n4521), .A2(n4516), .A3(n4736), .A4(n4515), .Y(n1850) );
  INVX1_HVT U5476 ( .A(n4517), .Y(n4520) );
  INVX1_HVT U5477 ( .A(n4518), .Y(n4519) );
  OA221X1_HVT U5478 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter[3]), .A2(
        n4521), .A3(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter[3]), .A4(
        n4520), .A5(n4519), .Y(n1849) );
  NAND2X0_HVT U5479 ( .A1(n5170), .A2(n5501), .Y(n4524) );
  OA22X1_HVT U5480 ( .A1(n4526), .A2(n5103), .A3(sram_readyout), .A4(n4524), 
        .Y(n1815) );
  INVX1_HVT U5481 ( .A(uart_readyout), .Y(n4527) );
  OA22X1_HVT U5482 ( .A1(n4530), .A2(n5184), .A3(n4528), .A4(n4527), .Y(n4532)
         );
  NAND2X0_HVT U5483 ( .A1(n4532), .A2(n5530), .Y(n1814) );
  OR2X2_LVT U5484 ( .A1(spi_readyout), .A2(n5483), .Y(n4533) );
  INVX1_HVT U5485 ( .A(n4533), .Y(n4537) );
  INVX1_HVT U5486 ( .A(n4555), .Y(n4535) );
  INVX1_HVT U5487 ( .A(n4739), .Y(n4534) );
  OR2X2_LVT U5488 ( .A1(n4535), .A2(n4534), .Y(n4536) );
  OR2X2_LVT U5489 ( .A1(n4537), .A2(n4536), .Y(n4538) );
  NAND3X0_HVT U5490 ( .A1(n2686), .A2(n4539), .A3(n4538), .Y(n1813) );
  NAND2X0_HVT U5491 ( .A1(SPI_CS_n[0]), .A2(n4550), .Y(n4543) );
  NAND3X0_HVT U5495 ( .A1(n4543), .A2(n4546), .A3(n4548), .Y(n1812) );
  NAND2X0_HVT U5497 ( .A1(SPI_CS_n[1]), .A2(n4550), .Y(n4545) );
  NAND3X0_HVT U5498 ( .A1(n4546), .A2(n4551), .A3(n4545), .Y(n1811) );
  NAND2X0_HVT U5499 ( .A1(SPI_CS_n[2]), .A2(n4550), .Y(n4549) );
  OR2X2_LVT U5500 ( .A1(n4547), .A2(AHB_SPI_WRAPPER_slave_select[1]), .Y(n4552) );
  NAND3X0_HVT U5501 ( .A1(n4549), .A2(n4552), .A3(n4548), .Y(n1810) );
  NAND2X0_HVT U5502 ( .A1(SPI_CS_n[3]), .A2(n4550), .Y(n4553) );
  NAND3X0_HVT U5503 ( .A1(n4553), .A2(n4552), .A3(n4551), .Y(n1809) );
  OR2X2_LVT U5504 ( .A1(i2c_readyout), .A2(n5483), .Y(n4554) );
  INVX1_HVT U5505 ( .A(n4554), .Y(n4559) );
  INVX1_HVT U5506 ( .A(n4740), .Y(n4557) );
  INVX1_HVT U5507 ( .A(n4555), .Y(n4556) );
  OR2X2_LVT U5508 ( .A1(n4557), .A2(n4556), .Y(n4558) );
  OR2X2_LVT U5509 ( .A1(n4559), .A2(n4558), .Y(n4560) );
  NAND3X0_HVT U5510 ( .A1(n5532), .A2(n4561), .A3(n4560), .Y(n1808) );
  MUX41X1_HVT U5513 ( .A1(AHB_UART_WRAPPER_tx_data[4]), .A3(
        AHB_UART_WRAPPER_tx_data[12]), .A2(AHB_UART_WRAPPER_tx_data[20]), .A4(
        AHB_UART_WRAPPER_tx_data[28]), .S0(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter[0]), .S1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter[1]), .Y(
        n4567) );
  MUX21X1_HVT U5515 ( .A1(AHB_UART_WRAPPER_tx_data[5]), .A2(
        AHB_UART_WRAPPER_tx_data[21]), .S0(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter[1]), .Y(
        n4564) );
  NAND2X0_HVT U5516 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter[0]), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter[1]), .Y(
        n4578) );
  OA22X1_HVT U5517 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter[0]), .A2(
        n4564), .A3(AHB_UART_WRAPPER_tx_data[29]), .A4(n4578), .Y(n4565) );
  OA21X1_HVT U5518 ( .A1(AHB_UART_WRAPPER_tx_data[13]), .A2(n4581), .A3(n4565), 
        .Y(n4566) );
  OA221X1_HVT U5520 ( .A1(n5509), .A2(n4567), .A3(n5015), .A4(n4566), .A5(
        n5014), .Y(n4573) );
  MUX21X1_HVT U5521 ( .A1(AHB_UART_WRAPPER_tx_data[6]), .A2(
        AHB_UART_WRAPPER_tx_data[22]), .S0(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter[1]), .Y(
        n4569) );
  OA22X1_HVT U5522 ( .A1(AHB_UART_WRAPPER_tx_data[30]), .A2(n4578), .A3(
        AHB_UART_WRAPPER_tx_data[14]), .A4(n4581), .Y(n4568) );
  OA21X1_HVT U5523 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter[0]), .A2(
        n4569), .A3(n4568), .Y(n4571) );
  MUX41X1_HVT U5524 ( .A1(AHB_UART_WRAPPER_tx_data[7]), .A3(
        AHB_UART_WRAPPER_tx_data[15]), .A2(AHB_UART_WRAPPER_tx_data[23]), .A4(
        AHB_UART_WRAPPER_tx_data[31]), .S0(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter[0]), .S1(
        n5507), .Y(n4570) );
  OA221X1_HVT U5525 ( .A1(n5509), .A2(n4571), .A3(n5015), .A4(n4570), .A5(
        n5470), .Y(n4572) );
  MUX21X1_HVT U5527 ( .A1(AHB_UART_WRAPPER_tx_data[2]), .A2(
        AHB_UART_WRAPPER_tx_data[18]), .S0(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter[1]), .Y(
        n4575) );
  OA22X1_HVT U5528 ( .A1(AHB_UART_WRAPPER_tx_data[26]), .A2(n4578), .A3(
        AHB_UART_WRAPPER_tx_data[10]), .A4(n4581), .Y(n4574) );
  OA21X1_HVT U5529 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter[0]), .A2(
        n4575), .A3(n4574), .Y(n4577) );
  MUX41X1_HVT U5530 ( .A1(AHB_UART_WRAPPER_tx_data[3]), .A3(
        AHB_UART_WRAPPER_tx_data[11]), .A2(AHB_UART_WRAPPER_tx_data[19]), .A4(
        AHB_UART_WRAPPER_tx_data[27]), .S0(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter[0]), .S1(
        n5507), .Y(n4576) );
  OA221X1_HVT U5531 ( .A1(n5509), .A2(n4577), .A3(n5015), .A4(n4576), .A5(
        n5470), .Y(n4587) );
  MUX41X1_HVT U5532 ( .A1(AHB_UART_WRAPPER_tx_data[0]), .A3(
        AHB_UART_WRAPPER_tx_data[8]), .A2(AHB_UART_WRAPPER_tx_data[16]), .A4(
        AHB_UART_WRAPPER_tx_data[24]), .S0(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter[0]), .S1(
        n5507), .Y(n4585) );
  MUX21X1_HVT U5533 ( .A1(AHB_UART_WRAPPER_tx_data[1]), .A2(
        AHB_UART_WRAPPER_tx_data[17]), .S0(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter[1]), .Y(
        n4579) );
  OA22X1_HVT U5534 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter[0]), .A2(
        n4579), .A3(AHB_UART_WRAPPER_tx_data[25]), .A4(n4578), .Y(n4580) );
  OA21X1_HVT U5535 ( .A1(AHB_UART_WRAPPER_tx_data[9]), .A2(n4581), .A3(n4580), 
        .Y(n4583) );
  OA221X1_HVT U5536 ( .A1(n5509), .A2(n4585), .A3(n5015), .A4(n4583), .A5(
        n5014), .Y(n4586) );
  OR3X1_HVT U5538 ( .A1(AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_STATE[0]), 
        .A2(n4589), .A3(n4588), .Y(n4590) );
  NAND3X0_HVT U5539 ( .A1(AHB_UART_WRAPPER_UART_CONTROLLER_Txclk_en), .A2(
        n4590), .A3(AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_STATE[1]), 
        .Y(n4594) );
  NAND2X0_HVT U5540 ( .A1(n5488), .A2(n4591), .Y(n4592) );
  MUX41X1_HVT U5556 ( .A1(sram_rdata[20]), .A3(spi_rdata[20]), .A2(
        uart_rdata[20]), .A4(i2c_rdata[20]), .S0(n5092), .S1(n5095), .Y(
        HRDATA[20]) );
  MUX41X1_HVT U5557 ( .A1(sram_rdata[19]), .A3(spi_rdata[19]), .A2(
        uart_rdata[19]), .A4(i2c_rdata[19]), .S0(n5091), .S1(n5095), .Y(
        HRDATA[19]) );
  MUX41X1_HVT U5558 ( .A1(sram_rdata[18]), .A3(spi_rdata[18]), .A2(
        uart_rdata[18]), .A4(i2c_rdata[18]), .S0(n5092), .S1(n5095), .Y(
        HRDATA[18]) );
  MUX41X1_HVT U5561 ( .A1(sram_rdata[15]), .A3(spi_rdata[15]), .A2(
        uart_rdata[15]), .A4(i2c_rdata[15]), .S0(n5091), .S1(n5095), .Y(
        HRDATA[15]) );
  MUX41X1_HVT U5562 ( .A1(sram_rdata[14]), .A3(spi_rdata[14]), .A2(
        uart_rdata[14]), .A4(i2c_rdata[14]), .S0(n5091), .S1(n5095), .Y(
        HRDATA[14]) );
  MUX41X1_HVT U5566 ( .A1(sram_rdata[13]), .A3(spi_rdata[13]), .A2(
        uart_rdata[13]), .A4(i2c_rdata[13]), .S0(n5091), .S1(n5093), .Y(
        HRDATA[13]) );
  MUX41X1_HVT U5567 ( .A1(sram_rdata[12]), .A3(spi_rdata[12]), .A2(
        uart_rdata[12]), .A4(i2c_rdata[12]), .S0(n5091), .S1(n5093), .Y(
        HRDATA[12]) );
  MUX41X1_HVT U5568 ( .A1(sram_rdata[11]), .A3(spi_rdata[11]), .A2(
        uart_rdata[11]), .A4(i2c_rdata[11]), .S0(n5091), .S1(n5093), .Y(
        HRDATA[11]) );
  MUX41X1_HVT U5569 ( .A1(sram_rdata[10]), .A3(spi_rdata[10]), .A2(
        uart_rdata[10]), .A4(i2c_rdata[10]), .S0(n5091), .S1(n5093), .Y(
        HRDATA[10]) );
  MUX41X1_HVT U5570 ( .A1(sram_rdata[9]), .A3(spi_rdata[9]), .A2(uart_rdata[9]), .A4(i2c_rdata[9]), .S0(n5091), .S1(n5093), .Y(HRDATA[9]) );
  MUX41X1_HVT U5571 ( .A1(sram_rdata[8]), .A3(spi_rdata[8]), .A2(uart_rdata[8]), .A4(i2c_rdata[8]), .S0(n5091), .S1(n5093), .Y(HRDATA[8]) );
  MUX41X1_HVT U5572 ( .A1(sram_rdata[7]), .A3(spi_rdata[7]), .A2(uart_rdata[7]), .A4(i2c_rdata[7]), .S0(n5091), .S1(n5093), .Y(HRDATA[7]) );
  MUX41X1_HVT U5573 ( .A1(sram_rdata[6]), .A3(spi_rdata[6]), .A2(uart_rdata[6]), .A4(i2c_rdata[6]), .S0(n5091), .S1(n5093), .Y(HRDATA[6]) );
  MUX41X1_HVT U5574 ( .A1(sram_rdata[5]), .A3(spi_rdata[5]), .A2(uart_rdata[5]), .A4(i2c_rdata[5]), .S0(n5091), .S1(n5093), .Y(HRDATA[5]) );
  MUX41X1_HVT U5575 ( .A1(sram_rdata[4]), .A3(spi_rdata[4]), .A2(uart_rdata[4]), .A4(i2c_rdata[4]), .S0(n5091), .S1(n5093), .Y(HRDATA[4]) );
  MUX41X1_HVT U5576 ( .A1(sram_rdata[3]), .A3(spi_rdata[3]), .A2(uart_rdata[3]), .A4(i2c_rdata[3]), .S0(n5091), .S1(n5093), .Y(HRDATA[3]) );
  MUX41X1_HVT U5577 ( .A1(sram_rdata[2]), .A3(spi_rdata[2]), .A2(uart_rdata[2]), .A4(i2c_rdata[2]), .S0(n5091), .S1(n5093), .Y(HRDATA[2]) );
  MUX41X1_HVT U5578 ( .A1(sram_rdata[1]), .A3(spi_rdata[1]), .A2(uart_rdata[1]), .A4(i2c_rdata[1]), .S0(n5091), .S1(n5093), .Y(HRDATA[1]) );
  MUX41X1_HVT U5579 ( .A1(sram_rdata[0]), .A3(spi_rdata[0]), .A2(uart_rdata[0]), .A4(i2c_rdata[0]), .S0(n5091), .S1(n5095), .Y(HRDATA[0]) );
  OA221X1_HVT U4067 ( .A1(n5179), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_counter[1]), .A3(n5179), .A4(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_counter[0]), .A5(n3539), .Y(n4425)
         );
  OA21X2_HVT U4047 ( .A1(n5020), .A2(n4389), .A3(n5171), .Y(n3539) );
  NAND3X2_HVT U3834 ( .A1(n4360), .A2(n3445), .A3(n3464), .Y(n3446) );
  NAND2X0_HVT U3890 ( .A1(n5168), .A2(n3465), .Y(n4356) );
  NAND2X2_HVT U3935 ( .A1(n5135), .A2(n4274), .Y(n3505) );
  NAND2X2_HVT U5154 ( .A1(n5136), .A2(n4242), .Y(n4266) );
  NAND2X2_HVT U5158 ( .A1(n4667), .A2(n4246), .Y(n4267) );
  NAND2X2_HVT U5160 ( .A1(n5136), .A2(n4243), .Y(n4268) );
  NAND2X2_HVT U5164 ( .A1(n5136), .A2(n4245), .Y(n4270) );
  NAND2X2_HVT U5166 ( .A1(n4246), .A2(n5342), .Y(n4272) );
  NAND3X0_HVT U4883 ( .A1(n3975), .A2(n3974), .A3(n3973), .Y(n2522) );
  NAND2X4_HVT U4044 ( .A1(n4379), .A2(n4424), .Y(n4389) );
  NAND2X2_HVT U4117 ( .A1(n5483), .A2(n4662), .Y(n3590) );
  AND2X1_HVT U4128 ( .A1(n5483), .A2(n4740), .Y(n3581) );
  NAND2X4_HVT U4133 ( .A1(n5483), .A2(n4663), .Y(n4529) );
  AND2X1_HVT U4162 ( .A1(n5483), .A2(n4739), .Y(n3586) );
  NAND3X2_HVT U3734 ( .A1(n3410), .A2(n3409), .A3(n3408), .Y(n4472) );
  OR3X1_HVT U4060 ( .A1(n4379), .A2(n4365), .A3(n4374), .Y(n3642) );
  NAND3X2_HVT U5155 ( .A1(n5154), .A2(n4667), .A3(n4669), .Y(n4265) );
  NAND3X2_HVT U5162 ( .A1(n5154), .A2(n4669), .A3(n5342), .Y(n4269) );
  OR4X2_HVT U3084 ( .A1(n2826), .A2(n5258), .A3(n5265), .A4(n2823), .Y(n2828)
         );
  OR4X2_HVT U3119 ( .A1(n5256), .A2(n5166), .A3(n5165), .A4(n5254), .Y(n2851)
         );
  OR4X2_HVT U3157 ( .A1(n2871), .A2(n2870), .A3(n2869), .A4(n2868), .Y(n2872)
         );
  OR4X4_HVT U3180 ( .A1(n2892), .A2(n2891), .A3(n2890), .A4(n2889), .Y(n2893)
         );
  OR4X4_HVT U3202 ( .A1(n2913), .A2(n2912), .A3(n2911), .A4(n2910), .Y(n2914)
         );
  OR4X2_HVT U3246 ( .A1(n2955), .A2(n5272), .A3(n2953), .A4(n5263), .Y(n2956)
         );
  OR4X2_HVT U3268 ( .A1(n2976), .A2(n2975), .A3(n2974), .A4(n2973), .Y(n2977)
         );
  OR4X4_HVT U3290 ( .A1(n2997), .A2(n5164), .A3(n2995), .A4(n2994), .Y(n2998)
         );
  OR4X2_HVT U3312 ( .A1(n5163), .A2(n3017), .A3(n5260), .A4(n3015), .Y(n3019)
         );
  OR4X2_HVT U3334 ( .A1(n5162), .A2(n3038), .A3(n3037), .A4(n5262), .Y(n3040)
         );
  OR4X4_HVT U3356 ( .A1(n3060), .A2(n3059), .A3(n3058), .A4(n3057), .Y(n3061)
         );
  OR4X2_HVT U3378 ( .A1(n3081), .A2(n3080), .A3(n3079), .A4(n3078), .Y(n3082)
         );
  OR4X2_HVT U3400 ( .A1(n3102), .A2(n5161), .A3(n5149), .A4(n3099), .Y(n3103)
         );
  OR4X2_HVT U3422 ( .A1(n3123), .A2(n3122), .A3(n3121), .A4(n3120), .Y(n3124)
         );
  OR4X2_HVT U3444 ( .A1(n3144), .A2(n3143), .A3(n3142), .A4(n5255), .Y(n3145)
         );
  OR4X4_HVT U3466 ( .A1(n5160), .A2(n3164), .A3(n3163), .A4(n3162), .Y(n3166)
         );
  OR4X2_HVT U3532 ( .A1(n5251), .A2(n3227), .A3(n3226), .A4(n3225), .Y(n3229)
         );
  OR4X2_HVT U3554 ( .A1(n3249), .A2(n3248), .A3(n3247), .A4(n3246), .Y(n3250)
         );
  OR4X2_HVT U3576 ( .A1(n3270), .A2(n3269), .A3(n3268), .A4(n3267), .Y(n3271)
         );
  OR4X2_HVT U3664 ( .A1(n3355), .A2(n3354), .A3(n3353), .A4(n3352), .Y(n3356)
         );
  OR4X2_HVT U3686 ( .A1(n3376), .A2(n3375), .A3(n3374), .A4(n3373), .Y(n3377)
         );
  OR4X2_HVT U3708 ( .A1(n3397), .A2(n3396), .A3(n3395), .A4(n3394), .Y(n3399)
         );
  OR4X2_HVT U5021 ( .A1(n4106), .A2(n4105), .A3(n4104), .A4(n4103), .Y(n4108)
         );
  OR4X2_HVT U5060 ( .A1(n4144), .A2(n4143), .A3(n4142), .A4(n4141), .Y(n4145)
         );
  OR4X2_HVT U5082 ( .A1(n4165), .A2(n4164), .A3(n4163), .A4(n4162), .Y(n4166)
         );
  OR4X2_HVT U5104 ( .A1(n4202), .A2(n4201), .A3(n4200), .A4(n4199), .Y(n4203)
         );
  OAI222X2_HVT U4941 ( .A1(n4925), .A2(n5533), .A3(n4950), .A4(n5106), .A5(
        n4644), .A6(n5491), .Y(n2507) );
  OAI222X2_HVT U4974 ( .A1(n4658), .A2(n5491), .A3(n4939), .A4(n5106), .A5(
        n4917), .A6(n5533), .Y(n2495) );
  OAI222X2_HVT U4976 ( .A1(n4659), .A2(n3953), .A3(n4938), .A4(n5106), .A5(
        n4916), .A6(n5533), .Y(n2494) );
  NAND2X0_HVT U3822 ( .A1(n5017), .A2(n4370), .Y(n3441) );
  NAND2X2_HVT U3977 ( .A1(AHB_I2C_WRAPPER_i2c_start), .A2(n5132), .Y(n3507) );
  NAND2X2_HVT U4082 ( .A1(n5132), .A2(AHB_I2C_WRAPPER_tx_data[28]), .Y(n4323)
         );
  NAND2X2_HVT U4090 ( .A1(n5132), .A2(AHB_I2C_WRAPPER_tx_data[29]), .Y(n4324)
         );
  NAND2X2_HVT U4106 ( .A1(n5132), .A2(AHB_I2C_WRAPPER_tx_data[26]), .Y(n4322)
         );
  OA21X1_HVT U3881 ( .A1(n5120), .A2(n4719), .A3(n4331), .Y(n4401) );
  NAND4X0_HVT U3066 ( .A1(n2813), .A2(n2812), .A3(n2811), .A4(n2810), .Y(n5497) );
  NAND4X0_HVT U3103 ( .A1(n2834), .A2(n2833), .A3(n2832), .A4(n2831), .Y(n5351) );
  NAND4X0_HVT U3108 ( .A1(n2838), .A2(n2837), .A3(n2836), .A4(n2835), .Y(n2849) );
  NAND4X0_HVT U3113 ( .A1(n2842), .A2(n5148), .A3(n2840), .A4(n2839), .Y(n2848) );
  NAND4X0_HVT U3118 ( .A1(n2846), .A2(n2845), .A3(n2844), .A4(n2843), .Y(n5320) );
  NAND4X0_HVT U3208 ( .A1(n2918), .A2(n2917), .A3(n2916), .A4(n2915), .Y(n2934) );
  NAND4X0_HVT U3235 ( .A1(n2943), .A2(n2942), .A3(n2941), .A4(n2940), .Y(n2954) );
  NAND4X1_HVT U3240 ( .A1(n2947), .A2(n2946), .A3(n2945), .A4(n2944), .Y(n5368) );
  NAND4X0_HVT U3245 ( .A1(n2951), .A2(n2950), .A3(n2949), .A4(n2948), .Y(n5411) );
  NAND4X0_HVT U3279 ( .A1(n2985), .A2(n2984), .A3(n2983), .A4(n2982), .Y(n2996) );
  NAND4X0_HVT U3296 ( .A1(n3002), .A2(n3001), .A3(n3000), .A4(n2999), .Y(n3018) );
  NAND4X0_HVT U3306 ( .A1(n3010), .A2(n3009), .A3(n3008), .A4(n3007), .Y(n5397) );
  NAND4X0_HVT U3318 ( .A1(n3023), .A2(n3022), .A3(n3021), .A4(n3020), .Y(n3039) );
  NAND4X0_HVT U3389 ( .A1(n3090), .A2(n3089), .A3(n3088), .A4(n3087), .Y(n3101) );
  NAND4X0_HVT U3443 ( .A1(n3140), .A2(n3139), .A3(n3138), .A4(n3137), .Y(n5307) );
  NAND4X0_HVT U3450 ( .A1(n3149), .A2(n3148), .A3(n3147), .A4(n3146), .Y(n3165) );
  NAND4X0_HVT U3487 ( .A1(n3182), .A2(n3181), .A3(n3180), .A4(n3179), .Y(n5306) );
  NAND4X0_HVT U3494 ( .A1(n3191), .A2(n3190), .A3(n3189), .A4(n3188), .Y(n5514) );
  NAND4X0_HVT U3499 ( .A1(n3195), .A2(n3194), .A3(n3193), .A4(n3192), .Y(n5390) );
  NAND4X0_HVT U3504 ( .A1(n3199), .A2(n3198), .A3(n3197), .A4(n3196), .Y(n5353) );
  NAND4X0_HVT U3516 ( .A1(n3212), .A2(n3211), .A3(n3210), .A4(n3209), .Y(n5291) );
  NAND4X0_HVT U3604 ( .A1(n3296), .A2(n3295), .A3(n3294), .A4(n3293), .Y(n5516) );
  NAND4X0_HVT U3609 ( .A1(n3300), .A2(n3299), .A3(n3298), .A4(n3297), .Y(n5305) );
  NAND4X0_HVT U3636 ( .A1(n3325), .A2(n3324), .A3(n3323), .A4(n3322), .Y(n5322) );
  NAND2X2_HVT U4551 ( .A1(n2805), .A2(n5293), .Y(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[4]) );
  NAND2X2_HVT U4553 ( .A1(n5415), .A2(n5293), .Y(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[6]) );
  NAND2X4_HVT U4556 ( .A1(n5376), .A2(n5293), .Y(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[9]) );
  NAND2X2_HVT U4560 ( .A1(n2798), .A2(n5293), .Y(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[13]) );
  NAND2X2_HVT U4561 ( .A1(n2799), .A2(n5293), .Y(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[14]) );
  NAND2X2_HVT U3018 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[12]), .Y(n2796) );
  NAND2X4_HVT U3053 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[12]), .Y(n2813) );
  NAND2X4_HVT U3074 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[12]), .Y(n2821) );
  NAND2X4_HVT U3082 ( .A1(n5415), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[12]), .Y(n2819) );
  NAND2X2_HVT U3153 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[15]), .Y(n2865) );
  NAND2X0_HVT U3172 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[7]), .Y(n2882) );
  NAND2X2_HVT U3178 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[7]), .Y(n2885) );
  NAND2X4_HVT U3188 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[19]), .Y(n2900) );
  NAND2X4_HVT U3281 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[11]), .Y(n2988) );
  NAND2X2_HVT U3285 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[11]), .Y(n2993) );
  NAND2X4_HVT U3286 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[11]), .Y(n2992) );
  NAND2X2_HVT U3288 ( .A1(n2807), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[11]), .Y(n2990) );
  NAND2X2_HVT U3297 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[8]), .Y(n3006) );
  NAND2X4_HVT U3310 ( .A1(n5415), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[8]), .Y(n3011) );
  NAND2X4_HVT U3319 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[4]), .Y(n3027) );
  NAND2X4_HVT U3327 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[4]), .Y(n3028) );
  NAND2X2_HVT U3339 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[20]), .Y(n3041) );
  NAND2X4_HVT U3348 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[20]), .Y(n3050) );
  NAND2X2_HVT U3358 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[23]), .Y(n3065) );
  NAND2X4_HVT U3363 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[23]), .Y(n3069) );
  NAND2X4_HVT U3381 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[0]), .Y(n3085) );
  NAND2X4_HVT U3387 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[0]), .Y(n3088) );
  NAND2X2_HVT U3397 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[0]), .Y(n3096) );
  NAND2X4_HVT U3413 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[24]), .Y(n3114) );
  NAND2X4_HVT U3430 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[17]), .Y(n3131) );
  NAND2X4_HVT U3441 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[17]), .Y(n3138) );
  NAND2X2_HVT U3448 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[13]), .Y(n3147) );
  NAND2X2_HVT U3449 ( .A1(n5525), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[13]), .Y(n3146) );
  NAND2X4_HVT U3454 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[13]), .Y(n3150) );
  NAND2X0_HVT U3464 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[13]), .Y(n3158) );
  NAND2X4_HVT U3468 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[2]), .Y(n3170) );
  NAND2X4_HVT U3474 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[2]), .Y(n3173) );
  NAND2X4_HVT U3501 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[3]), .Y(n3198) );
  NAND2X4_HVT U3515 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[22]), .Y(n3209) );
  NAND2X4_HVT U3550 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[21]), .Y(n3244) );
  NAND2X4_HVT U3556 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[16]), .Y(n3254) );
  NAND2X4_HVT U3579 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[18]), .Y(n3274) );
  NAND2X4_HVT U3616 ( .A1(n5376), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[10]), .Y(n3307) );
  NAND2X2_HVT U3617 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[10]), .Y(n3306) );
  NAND2X0_HVT U3630 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[6]), .Y(n3318) );
  NAND2X2_HVT U3638 ( .A1(n5486), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram1_rdata[6]), .Y(n3328) );
  NAND2X4_HVT U3647 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[26]), .Y(n3336) );
  NAND2X4_HVT U3669 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[27]), .Y(n3357) );
  NAND2X2_HVT U3679 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[27]), .Y(n3365) );
  NAND2X4_HVT U3695 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[14]), .Y(n3383) );
  NAND2X4_HVT U5007 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[28]), .Y(n4085) );
  NAND2X2_HVT U5013 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[28]), .Y(n4092) );
  NAND2X4_HVT U5036 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[29]), .Y(n4123) );
  NAND2X4_HVT U5073 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[30]), .Y(n4156) );
  NAND2X4_HVT U5092 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[31]), .Y(n4179) );
  NAND3X2_HVT U5334 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_counter[0]), .A2(
        n5127), .A3(n5285), .Y(n4447) );
  NAND3X2_HVT U5347 ( .A1(n5127), .A2(n4725), .A3(n5285), .Y(n4445) );
  NAND3X2_HVT U5353 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_counter[1]), .A2(
        n5127), .A3(n4725), .Y(n4449) );
  NAND3X2_HVT U5356 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_counter[0]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_counter[1]), .A3(n5127), .Y(n4452)
         );
  NAND4X0_HVT U3048 ( .A1(n2804), .A2(n2803), .A3(n2802), .A4(n2801), .Y(n5366) );
  NAND4X0_HVT U3333 ( .A1(n3035), .A2(n3034), .A3(n5145), .A4(n3032), .Y(n5416) );
  NAND4X0_HVT U3394 ( .A1(n3094), .A2(n3093), .A3(n3092), .A4(n3091), .Y(n3100) );
  AND4X2_HVT U4372 ( .A1(n4876), .A2(n4869), .A3(n4874), .A4(n4053), .Y(n4217)
         );
  NAND2X2_HVT U3026 ( .A1(n2791), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[12]), .Y(n2794) );
  NAND2X4_HVT U3030 ( .A1(n5517), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[12]), .Y(n2793) );
  NAND2X2_HVT U3057 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[12]), .Y(n2812) );
  NAND2X4_HVT U3078 ( .A1(n5427), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[12]), .Y(n2820) );
  NAND2X2_HVT U3100 ( .A1(n2797), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[9]), .Y(n2833) );
  NAND2X2_HVT U3102 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[9]), .Y(n2831) );
  NAND2X4_HVT U3107 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[9]), .Y(n2835) );
  NAND2X0_HVT U3110 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[9]), .Y(n2841) );
  NAND2X4_HVT U3111 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[9]), .Y(n2840) );
  NAND2X4_HVT U3124 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[15]), .Y(n2854) );
  NAND2X2_HVT U3128 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[15]), .Y(n2852) );
  NAND2X4_HVT U3137 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[15]), .Y(n2856) );
  NAND2X4_HVT U3146 ( .A1(n5278), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[15]), .Y(n2860) );
  NAND2X4_HVT U3151 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[15]), .Y(n2866) );
  NAND2X0_HVT U3161 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[7]), .Y(n2875) );
  NAND2X2_HVT U3167 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[7]), .Y(n2878) );
  NAND2X0_HVT U3170 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[7]), .Y(n2884) );
  NAND2X4_HVT U3182 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[19]), .Y(n2897) );
  NAND2X4_HVT U3183 ( .A1(n5278), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[19]), .Y(n2896) );
  NAND2X2_HVT U3197 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[19]), .Y(n2909) );
  NAND2X2_HVT U3214 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[1]), .Y(n2926) );
  NAND2X4_HVT U3226 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[5]), .Y(n2939) );
  NAND2X2_HVT U3243 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[5]), .Y(n2949) );
  NAND2X2_HVT U3251 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[25]), .Y(n2957) );
  NAND2X4_HVT U3261 ( .A1(n5278), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[25]), .Y(n2965) );
  NAND2X4_HVT U3275 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[11]), .Y(n2985) );
  NAND2X2_HVT U3282 ( .A1(n5427), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[11]), .Y(n2987) );
  NAND2X2_HVT U3292 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[8]), .Y(n3002) );
  NAND2X4_HVT U3305 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[8]), .Y(n3007) );
  NAND2X4_HVT U3307 ( .A1(n5427), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[8]), .Y(n3014) );
  NAND2X4_HVT U3308 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[8]), .Y(n3013) );
  NAND2X4_HVT U3324 ( .A1(n5517), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[4]), .Y(n3031) );
  NAND2X2_HVT U3326 ( .A1(n2791), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[4]), .Y(n3029) );
  NAND2X0_HVT U3331 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[4]), .Y(n3033) );
  NAND2X4_HVT U3349 ( .A1(n5278), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[20]), .Y(n3049) );
  NAND2X2_HVT U3359 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[23]), .Y(n3064) );
  NAND2X4_HVT U3369 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[23]), .Y(n3072) );
  NAND2X4_HVT U3373 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[23]), .Y(n3077) );
  NAND2X2_HVT U3376 ( .A1(n5278), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[23]), .Y(n3074) );
  NAND2X2_HVT U3385 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[0]), .Y(n3090) );
  NAND2X4_HVT U3391 ( .A1(n5278), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[0]), .Y(n3093) );
  NAND2X4_HVT U3393 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[0]), .Y(n3091) );
  NAND2X0_HVT U3396 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[0]), .Y(n3097) );
  NAND2X2_HVT U3407 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[24]), .Y(n3111) );
  NAND2X0_HVT U3410 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[24]), .Y(n3108) );
  NAND2X4_HVT U3414 ( .A1(n5278), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[24]), .Y(n3113) );
  NAND2X4_HVT U3418 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[24]), .Y(n3118) );
  NAND2X4_HVT U3425 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[17]), .Y(n3127) );
  NAND2X0_HVT U3427 ( .A1(n5278), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[17]), .Y(n3125) );
  NAND2X2_HVT U3452 ( .A1(n5426), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[13]), .Y(n3152) );
  NAND2X2_HVT U3458 ( .A1(n5427), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[13]), .Y(n3155) );
  NAND2X2_HVT U3461 ( .A1(n2791), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[13]), .Y(n3161) );
  NAND2X4_HVT U3462 ( .A1(n5458), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[13]), .Y(n3160) );
  NAND2X2_HVT U3469 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[2]), .Y(n3169) );
  NAND2X4_HVT U3471 ( .A1(n5427), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[2]), .Y(n3167) );
  NAND2X2_HVT U3478 ( .A1(n5517), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[2]), .Y(n3178) );
  NAND2X2_HVT U3479 ( .A1(n2791), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[2]), .Y(n3177) );
  NAND2X2_HVT U3481 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[2]), .Y(n3175) );
  NAND2X2_HVT U3485 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[2]), .Y(n3180) );
  NAND2X4_HVT U3493 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[3]), .Y(n3188) );
  NAND2X2_HVT U3496 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[3]), .Y(n3194) );
  NAND2X4_HVT U3503 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[3]), .Y(n3196) );
  NAND2X2_HVT U3505 ( .A1(n5278), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[3]), .Y(n3203) );
  NAND2X0_HVT U3508 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[3]), .Y(n3200) );
  NAND2X2_HVT U3523 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[22]), .Y(n3219) );
  NAND2X4_HVT U3530 ( .A1(n5517), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[22]), .Y(n3221) );
  NAND2X2_HVT U3539 ( .A1(n5278), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[21]), .Y(n3237) );
  NAND2X2_HVT U3544 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[21]), .Y(n3241) );
  NAND2X2_HVT U3558 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[16]), .Y(n3252) );
  NAND2X4_HVT U3569 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[16]), .Y(n3259) );
  NAND2X2_HVT U3571 ( .A1(n5426), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[16]), .Y(n3266) );
  NAND2X4_HVT U3572 ( .A1(n5517), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[16]), .Y(n3265) );
  NAND2X4_HVT U3578 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[18]), .Y(n3275) );
  NAND2X0_HVT U3596 ( .A1(n5278), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[18]), .Y(n3284) );
  NAND2X0_HVT U3608 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[10]), .Y(n3297) );
  NAND2X0_HVT U3610 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[10]), .Y(n3304) );
  NAND2X4_HVT U3611 ( .A1(n2791), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[10]), .Y(n3303) );
  NAND2X4_HVT U3618 ( .A1(n5517), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[10]), .Y(n3305) );
  NAND2X2_HVT U3627 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[6]), .Y(n3321) );
  NAND2X4_HVT U3628 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[6]), .Y(n3320) );
  NAND2X2_HVT U3629 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[6]), .Y(n3319) );
  NAND2X2_HVT U3637 ( .A1(n5399), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram3_rdata[6]), .Y(n3329) );
  NAND2X0_HVT U3640 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[6]), .Y(n3326) );
  NAND2X4_HVT U3655 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[26]), .Y(n3346) );
  NAND2X2_HVT U3659 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[26]), .Y(n3351) );
  NAND2X4_HVT U3661 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[26]), .Y(n3349) );
  NAND2X4_HVT U3678 ( .A1(n2798), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram13_rdata[27]), .Y(n3366) );
  NAND2X4_HVT U3681 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[27]), .Y(n3372) );
  NAND2X2_HVT U3689 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[14]), .Y(n3380) );
  NAND2X4_HVT U3694 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[14]), .Y(n3384) );
  NAND2X2_HVT U3703 ( .A1(n5278), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[14]), .Y(n3393) );
  NAND2X4_HVT U3704 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[14]), .Y(n3392) );
  NAND2X2_HVT U5001 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[28]), .Y(n4078) );
  NAND2X2_HVT U5011 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[28]), .Y(n4094) );
  NAND2X4_HVT U5014 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[28]), .Y(n4091) );
  NAND2X0_HVT U5017 ( .A1(n5278), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[28]), .Y(n4101) );
  NAND2X4_HVT U5027 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[29]), .Y(n4115) );
  NAND2X4_HVT U5068 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[30]), .Y(n4152) );
  NAND2X4_HVT U5097 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[31]), .Y(n4187) );
  NAND2X4_HVT U5492 ( .A1(n5121), .A2(AHB_SPI_WRAPPER_slave_select[1]), .Y(
        n4546) );
  NAND3X2_HVT U2763 ( .A1(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[5]), .A2(
        n2700), .A3(n2699), .Y(n3710) );
  NAND3X2_HVT U3975 ( .A1(n5119), .A2(n5016), .A3(n5381), .Y(n4396) );
  NAND3X2_HVT U4336 ( .A1(n5531), .A2(n5115), .A3(n4305), .Y(n3606) );
  NAND4X0_HVT U3987 ( .A1(n3509), .A2(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[3]), 
        .A3(n5505), .A4(n5120), .Y(n4366) );
  AND4X2_HVT U4043 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[2]), .A2(n5119), 
        .A3(n5381), .A4(n4384), .Y(n4424) );
  NAND2X4_HVT U5133 ( .A1(n4224), .A2(n4223), .Y(n4550) );
  NAND3X2_HVT U2811 ( .A1(n2713), .A2(n3853), .A3(n4631), .Y(n2714) );
  NAND3X2_HVT U2866 ( .A1(n2719), .A2(n4621), .A3(n4620), .Y(n2720) );
  NAND3X2_HVT U2989 ( .A1(n4477), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Counter[0]), .A3(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Counter[1]), .Y(
        n3400) );
  NAND3X2_HVT U3005 ( .A1(n4477), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Counter[1]), .A3(
        n4738), .Y(n2829) );
  NAND3X2_HVT U3008 ( .A1(n4477), .A2(n4738), .A3(n2788), .Y(n2830) );
  NAND3X2_HVT U3744 ( .A1(AHB_UART_WRAPPER_sl_addr[2]), .A2(n5504), .A3(n4620), 
        .Y(n3412) );
  NAND3X2_HVT U4566 ( .A1(n5504), .A2(n4621), .A3(n4620), .Y(n3730) );
  NAND3X2_HVT U4718 ( .A1(AHB_SPI_WRAPPER_sl_addr[2]), .A2(n3852), .A3(n4631), 
        .Y(n3851) );
  AND3X2_HVT U4722 ( .A1(AHB_SPI_WRAPPER_sl_addr[2]), .A2(
        AHB_SPI_WRAPPER_sl_addr[3]), .A3(n3852), .Y(n3891) );
  NAND3X2_HVT U4724 ( .A1(n3853), .A2(n4631), .A3(n3852), .Y(n3854) );
  NAND3X2_HVT U4850 ( .A1(AHB_I2C_WRAPPER_sl_addr[3]), .A2(n3952), .A3(n3949), 
        .Y(n3964) );
  NAND3X2_HVT U4851 ( .A1(AHB_I2C_WRAPPER_sl_addr[2]), .A2(
        AHB_I2C_WRAPPER_sl_addr[3]), .A3(n3952), .Y(n3988) );
  NAND3X2_HVT U4853 ( .A1(n3949), .A2(n4660), .A3(n3952), .Y(n3950) );
  NAND3X2_HVT U4858 ( .A1(AHB_I2C_WRAPPER_sl_addr[2]), .A2(n3952), .A3(n4660), 
        .Y(n3953) );
  NAND4X0_HVT U3787 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_size[0]), .A2(
        n3418), .A3(n4725), .A4(n3419), .Y(n4399) );
  MUX41X2_HVT U5544 ( .A1(sram_rdata[29]), .A3(spi_rdata[29]), .A2(
        uart_rdata[29]), .A4(i2c_rdata[29]), .S0(n5092), .S1(n5094), .Y(
        HRDATA[29]) );
  MUX41X2_HVT U5548 ( .A1(sram_rdata[27]), .A3(spi_rdata[27]), .A2(
        uart_rdata[27]), .A4(i2c_rdata[27]), .S0(n5092), .S1(n5094), .Y(
        HRDATA[27]) );
  MUX41X2_HVT U5551 ( .A1(sram_rdata[25]), .A3(spi_rdata[25]), .A2(
        uart_rdata[25]), .A4(i2c_rdata[25]), .S0(n5092), .S1(n5095), .Y(
        HRDATA[25]) );
  MUX41X2_HVT U5552 ( .A1(sram_rdata[24]), .A3(spi_rdata[24]), .A2(
        uart_rdata[24]), .A4(i2c_rdata[24]), .S0(n5092), .S1(n5095), .Y(
        HRDATA[24]) );
  MUX41X2_HVT U5553 ( .A1(sram_rdata[23]), .A3(spi_rdata[23]), .A2(
        uart_rdata[23]), .A4(i2c_rdata[23]), .S0(n5092), .S1(n5095), .Y(
        HRDATA[23]) );
  MUX41X2_HVT U5554 ( .A1(sram_rdata[22]), .A3(spi_rdata[22]), .A2(
        uart_rdata[22]), .A4(i2c_rdata[22]), .S0(n5092), .S1(n5095), .Y(
        HRDATA[22]) );
  MUX41X2_HVT U5555 ( .A1(sram_rdata[21]), .A3(spi_rdata[21]), .A2(
        uart_rdata[21]), .A4(i2c_rdata[21]), .S0(n5091), .S1(n5095), .Y(
        HRDATA[21]) );
  MUX41X2_HVT U5559 ( .A1(sram_rdata[17]), .A3(spi_rdata[17]), .A2(
        uart_rdata[17]), .A4(i2c_rdata[17]), .S0(n5091), .S1(n5095), .Y(
        HRDATA[17]) );
  MUX41X1_HVT U5560 ( .A1(sram_rdata[16]), .A3(spi_rdata[16]), .A2(
        uart_rdata[16]), .A4(i2c_rdata[16]), .S0(n5091), .S1(n5095), .Y(
        HRDATA[16]) );
  NAND2X2_HVT U2916 ( .A1(n5031), .A2(n5030), .Y(n4547) );
  NAND2X2_HVT U3792 ( .A1(n5016), .A2(n4718), .Y(n4368) );
  NAND2X4_HVT U4031 ( .A1(n4411), .A2(n4410), .Y(n4412) );
  NAND2X4_HVT U4035 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_counter[1]), .A2(
        n4411), .Y(n3575) );
  NAND2X2_HVT U5512 ( .A1(UART_Tx), .A2(n4563), .Y(n4595) );
  AND3X2_HVT U3015 ( .A1(AHB_SRAM_WRAPPER_sl_addr[11]), .A2(n2808), .A3(n4613), 
        .Y(n2789) );
  NAND3X0_HVT U4525 ( .A1(AHB_SRAM_WRAPPER_sl_wstrb[0]), .A2(
        AHB_SRAM_WRAPPER_sl_wstrb[1]), .A3(n3692), .Y(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER__0_net_) );
  OA21X2_HVT U5440 ( .A1(n5499), .A2(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_STATE[0]), .A3(n5010), 
        .Y(n4513) );
  NAND2X2_HVT U2919 ( .A1(AHB_SPI_WRAPPER_SPI_CONTROLLER_STATE[0]), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_STATE[1]), .Y(n4281) );
  NAND2X4_HVT U3742 ( .A1(AHB_UART_WRAPPER_valid_trans), .A2(n4606), .Y(n3763)
         );
  NAND2X4_HVT U4848 ( .A1(AHB_I2C_WRAPPER_valid_trans), .A2(n4632), .Y(n3994)
         );
  NAND2X4_HVT U5511 ( .A1(AHB_UART_WRAPPER_UART_CONTROLLER_Txclk_en), .A2(
        n4741), .Y(n4563) );
  NAND3X2_HVT U2657 ( .A1(AHB_SPI_WRAPPER_AHB_SPI_SUB_READ_WAIT), .A2(
        AHB_SPI_WRAPPER_AHB_SPI_SUB_read_wait_counter[0]), .A3(
        AHB_SPI_WRAPPER_AHB_SPI_SUB_read_wait_counter[1]), .Y(n2686) );
  NAND3X2_HVT U2689 ( .A1(AHB_I2C_WRAPPER_AHB_I2C_SUB_READ_WAIT), .A2(
        AHB_I2C_WRAPPER_AHB_I2C_SUB_read_wait_counter[0]), .A3(
        AHB_I2C_WRAPPER_AHB_I2C_SUB_read_wait_counter[1]), .Y(n2689) );
  NAND3X2_HVT U2776 ( .A1(AHB_UART_WRAPPER_AHB_UART_SUB_READ_WAIT), .A2(
        AHB_UART_WRAPPER_AHB_UART_SUB_read_wait_counter[0]), .A3(
        AHB_UART_WRAPPER_AHB_UART_SUB_read_wait_counter[1]), .Y(n2708) );
  NAND3X2_HVT U3085 ( .A1(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_READ_WAIT), .A2(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_read_wait_counter[1]), .A3(n4661), .Y(
        n4522) );
  NAND3X2_HVT U3810 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[2]), .A2(n4719), 
        .A3(n5381), .Y(n3612) );
  AND4X4_HVT U3027 ( .A1(AHB_SRAM_WRAPPER_sl_addr[11]), .A2(
        AHB_SRAM_WRAPPER_sl_addr[8]), .A3(AHB_SRAM_WRAPPER_sl_addr[10]), .A4(
        AHB_SRAM_WRAPPER_sl_addr[9]), .Y(n2792) );
  AND4X4_HVT U3036 ( .A1(AHB_SRAM_WRAPPER_sl_addr[8]), .A2(
        AHB_SRAM_WRAPPER_sl_addr[11]), .A3(AHB_SRAM_WRAPPER_sl_addr[10]), .A4(
        n4612), .Y(n2798) );
  AND4X4_HVT U3040 ( .A1(AHB_SRAM_WRAPPER_sl_addr[11]), .A2(
        AHB_SRAM_WRAPPER_sl_addr[10]), .A3(AHB_SRAM_WRAPPER_sl_addr[9]), .A4(
        n4613), .Y(n2799) );
  AND4X4_HVT U3054 ( .A1(AHB_SRAM_WRAPPER_sl_addr[8]), .A2(
        AHB_SRAM_WRAPPER_sl_addr[11]), .A3(AHB_SRAM_WRAPPER_sl_addr[9]), .A4(
        n4611), .Y(n2806) );
  AND4X4_HVT U3067 ( .A1(AHB_SRAM_WRAPPER_sl_addr[11]), .A2(
        AHB_SRAM_WRAPPER_sl_addr[10]), .A3(n4613), .A4(n4612), .Y(n2814) );
  NBUFFX4_HVT U2659 ( .A(UART_Rx), .Y(n4816) );
  NBUFFX2_HVT U2662 ( .A(HTRANS[1]), .Y(n4817) );
  NBUFFX4_HVT U2690 ( .A(n4817), .Y(n4818) );
  NBUFFX4_HVT U2691 ( .A(HWRITE), .Y(n4819) );
  INVX1_HVT U2695 ( .A(n4819), .Y(n4820) );
  NBUFFX2_HVT U2721 ( .A(HWSTRB[0]), .Y(n4821) );
  NBUFFX4_HVT U2722 ( .A(HWSTRB[1]), .Y(n4822) );
  NBUFFX4_HVT U2723 ( .A(HWSTRB[2]), .Y(n4823) );
  NBUFFX4_HVT U2724 ( .A(HWSTRB[3]), .Y(n4824) );
  NBUFFX2_HVT U2725 ( .A(HWDATA[0]), .Y(n4825) );
  NBUFFX2_HVT U2764 ( .A(HWDATA[1]), .Y(n4826) );
  NBUFFX2_HVT U2772 ( .A(HWDATA[2]), .Y(n4827) );
  NBUFFX2_HVT U2777 ( .A(HWDATA[3]), .Y(n4828) );
  NBUFFX2_HVT U2778 ( .A(HWDATA[4]), .Y(n4829) );
  NBUFFX2_HVT U2779 ( .A(HWDATA[5]), .Y(n4830) );
  NBUFFX2_HVT U2794 ( .A(HWDATA[6]), .Y(n4831) );
  NBUFFX2_HVT U2795 ( .A(HWDATA[7]), .Y(n4832) );
  NBUFFX2_HVT U2812 ( .A(HWDATA[8]), .Y(n4833) );
  NBUFFX2_HVT U2813 ( .A(HWDATA[9]), .Y(n4834) );
  NBUFFX2_HVT U2817 ( .A(HWDATA[10]), .Y(n4835) );
  NBUFFX2_HVT U2818 ( .A(HWDATA[11]), .Y(n4836) );
  NBUFFX2_HVT U2827 ( .A(HWDATA[12]), .Y(n4837) );
  NBUFFX2_HVT U2833 ( .A(HWDATA[13]), .Y(n4838) );
  NBUFFX2_HVT U2867 ( .A(HWDATA[14]), .Y(n4839) );
  NBUFFX2_HVT U2868 ( .A(HWDATA[15]), .Y(n4840) );
  NBUFFX2_HVT U2870 ( .A(HWDATA[16]), .Y(n4841) );
  NBUFFX2_HVT U2914 ( .A(HWDATA[17]), .Y(n4842) );
  NBUFFX2_HVT U2915 ( .A(HWDATA[18]), .Y(n4843) );
  NBUFFX2_HVT U2920 ( .A(HWDATA[19]), .Y(n4844) );
  NBUFFX2_HVT U2924 ( .A(HWDATA[20]), .Y(n4845) );
  NBUFFX2_HVT U2925 ( .A(HWDATA[21]), .Y(n4846) );
  NBUFFX2_HVT U2941 ( .A(HWDATA[22]), .Y(n4847) );
  NBUFFX2_HVT U2963 ( .A(HWDATA[23]), .Y(n4848) );
  NBUFFX2_HVT U2982 ( .A(HWDATA[24]), .Y(n4849) );
  NBUFFX2_HVT U2990 ( .A(HWDATA[25]), .Y(n4850) );
  NBUFFX2_HVT U3016 ( .A(HWDATA[26]), .Y(n4851) );
  NBUFFX2_HVT U3017 ( .A(HWDATA[27]), .Y(n4852) );
  NBUFFX2_HVT U3020 ( .A(HWDATA[28]), .Y(n4853) );
  NBUFFX2_HVT U3021 ( .A(HWDATA[29]), .Y(n4854) );
  NBUFFX2_HVT U3024 ( .A(HWDATA[30]), .Y(n4855) );
  NBUFFX2_HVT U3025 ( .A(HWDATA[31]), .Y(n4856) );
  NBUFFX2_HVT U3028 ( .A(HADDR[0]), .Y(n4857) );
  NBUFFX2_HVT U3033 ( .A(HADDR[1]), .Y(n4859) );
  NBUFFX2_HVT U3034 ( .A(HADDR[2]), .Y(n4860) );
  NBUFFX2_HVT U3037 ( .A(HADDR[3]), .Y(n4861) );
  NBUFFX2_HVT U3038 ( .A(HADDR[4]), .Y(n4862) );
  NBUFFX2_HVT U3041 ( .A(HADDR[7]), .Y(n4863) );
  NBUFFX2_HVT U3042 ( .A(HADDR[8]), .Y(n4864) );
  NBUFFX2_HVT U3045 ( .A(HADDR[9]), .Y(n4865) );
  NBUFFX2_HVT U3046 ( .A(HADDR[10]), .Y(n4866) );
  NBUFFX2_HVT U3051 ( .A(HADDR[11]), .Y(n4867) );
  NBUFFX2_HVT U3052 ( .A(HADDR[19]), .Y(n4868) );
  INVX1_HVT U3055 ( .A(n4868), .Y(n4869) );
  NBUFFX8_HVT U3056 ( .A(HADDR[24]), .Y(n4870) );
  NBUFFX2_HVT U3059 ( .A(HADDR[27]), .Y(n4871) );
  NBUFFX2_HVT U3060 ( .A(HADDR[28]), .Y(n4872) );
  INVX1_HVT U3063 ( .A(n4872), .Y(n4873) );
  NBUFFX2_HVT U3064 ( .A(HADDR[29]), .Y(n4874) );
  NBUFFX2_HVT U3068 ( .A(HADDR[30]), .Y(n4875) );
  INVX1_HVT U3069 ( .A(n4875), .Y(n4876) );
  NBUFFX2_HVT U3072 ( .A(HADDR[31]), .Y(n4877) );
  NBUFFX8_HVT U3073 ( .A(HRESETn), .Y(n4878) );
  NBUFFX32_HVT U3076 ( .A(n4878), .Y(n4879) );
  NBUFFX32_HVT U3077 ( .A(n4878), .Y(n4880) );
  NBUFFX8_HVT U3081 ( .A(n4880), .Y(n4882) );
  NBUFFX4_HVT U3086 ( .A(n4880), .Y(n4883) );
  NBUFFX8_HVT U3087 ( .A(n4880), .Y(n4884) );
  NBUFFX8_HVT U3088 ( .A(n4880), .Y(n4885) );
  NBUFFX8_HVT U3121 ( .A(n4879), .Y(n4886) );
  NBUFFX8_HVT U3123 ( .A(n4879), .Y(n4887) );
  NBUFFX8_HVT U3125 ( .A(n4879), .Y(n4888) );
  NBUFFX8_HVT U3127 ( .A(n4879), .Y(n4889) );
  NBUFFX8_HVT U3130 ( .A(n4879), .Y(n4890) );
  NBUFFX8_HVT U3132 ( .A(n4879), .Y(n4891) );
  NBUFFX8_HVT U3134 ( .A(n4880), .Y(n4892) );
  NBUFFX8_HVT U3136 ( .A(n4880), .Y(n4893) );
  NBUFFX8_HVT U3139 ( .A(n4880), .Y(n4894) );
  NBUFFX4_HVT U3143 ( .A(n4880), .Y(n4896) );
  NBUFFX8_HVT U3145 ( .A(n4880), .Y(n4897) );
  NBUFFX8_HVT U3148 ( .A(n4880), .Y(n4898) );
  NBUFFX8_HVT U3150 ( .A(n4879), .Y(n4899) );
  NBUFFX4_HVT U3152 ( .A(n4879), .Y(n4900) );
  NBUFFX8_HVT U3154 ( .A(n4879), .Y(n4901) );
  NBUFFX8_HVT U3158 ( .A(n4880), .Y(n4902) );
  NBUFFX8_HVT U3720 ( .A(n4879), .Y(n4903) );
  NBUFFX8_HVT U3723 ( .A(n4879), .Y(n4904) );
  NBUFFX8_HVT U3738 ( .A(n4880), .Y(n4905) );
  NBUFFX8_HVT U3739 ( .A(n4880), .Y(n4906) );
  NBUFFX8_HVT U3745 ( .A(n4880), .Y(n4907) );
  NBUFFX8_HVT U3746 ( .A(n4880), .Y(n4908) );
  NBUFFX4_HVT U3747 ( .A(n4879), .Y(n4909) );
  NBUFFX4_HVT U3749 ( .A(n4880), .Y(n4910) );
  NBUFFX4_HVT U3778 ( .A(n4880), .Y(n4911) );
  NBUFFX8_HVT U3779 ( .A(n4879), .Y(n4912) );
  NBUFFX8_HVT U3780 ( .A(n4879), .Y(n4913) );
  NBUFFX4_HVT U3793 ( .A(n4880), .Y(n4914) );
  INVX1_HVT U3797 ( .A(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[0]), .Y(
        n4915) );
  INVX2_HVT U3814 ( .A(AHB_I2C_WRAPPER_tx_data[30]), .Y(n4917) );
  INVX1_HVT U3836 ( .A(AHB_I2C_WRAPPER_tx_data[26]), .Y(n4919) );
  INVX4_HVT U3837 ( .A(AHB_I2C_WRAPPER_tx_data[25]), .Y(n4920) );
  INVX1_HVT U3839 ( .A(AHB_I2C_WRAPPER_tx_data[23]), .Y(n4921) );
  INVX1_HVT U3841 ( .A(AHB_I2C_WRAPPER_tx_data[22]), .Y(n4922) );
  INVX1_HVT U3847 ( .A(AHB_I2C_WRAPPER_tx_data[20]), .Y(n4923) );
  INVX1_HVT U3870 ( .A(AHB_I2C_WRAPPER_tx_data[19]), .Y(n4924) );
  INVX1_HVT U3891 ( .A(AHB_I2C_WRAPPER_tx_data[18]), .Y(n4925) );
  INVX1_HVT U3901 ( .A(AHB_I2C_WRAPPER_tx_data[17]), .Y(n4926) );
  INVX1_HVT U3907 ( .A(AHB_I2C_WRAPPER_tx_data[16]), .Y(n4927) );
  INVX1_HVT U3911 ( .A(AHB_I2C_WRAPPER_tx_data[15]), .Y(n4928) );
  INVX1_HVT U3915 ( .A(AHB_I2C_WRAPPER_tx_data[13]), .Y(n4929) );
  INVX1_HVT U3961 ( .A(AHB_I2C_WRAPPER_tx_data[12]), .Y(n4930) );
  INVX1_HVT U3976 ( .A(AHB_I2C_WRAPPER_tx_data[11]), .Y(n4931) );
  INVX1_HVT U3978 ( .A(AHB_I2C_WRAPPER_tx_data[5]), .Y(n4932) );
  INVX1_HVT U3979 ( .A(AHB_I2C_WRAPPER_tx_data[4]), .Y(n4933) );
  INVX1_HVT U3980 ( .A(AHB_I2C_WRAPPER_tx_data[3]), .Y(n4934) );
  INVX1_HVT U3993 ( .A(AHB_I2C_WRAPPER_rx_byte_size[2]), .Y(n4935) );
  INVX1_HVT U3999 ( .A(AHB_I2C_WRAPPER_rx_byte_size[1]), .Y(n4936) );
  INVX1_HVT U4000 ( .A(AHB_I2C_WRAPPER_rx_byte_size[0]), .Y(n4937) );
  INVX1_HVT U4012 ( .A(AHB_I2C_WRAPPER_sl_rdata[31]), .Y(n4938) );
  INVX1_HVT U4028 ( .A(AHB_I2C_WRAPPER_sl_rdata[30]), .Y(n4939) );
  INVX1_HVT U4032 ( .A(AHB_I2C_WRAPPER_sl_rdata[29]), .Y(n4940) );
  INVX1_HVT U4034 ( .A(AHB_I2C_WRAPPER_sl_rdata[28]), .Y(n4941) );
  INVX1_HVT U4036 ( .A(AHB_I2C_WRAPPER_sl_rdata[27]), .Y(n4942) );
  INVX1_HVT U4038 ( .A(AHB_I2C_WRAPPER_sl_rdata[26]), .Y(n4943) );
  INVX1_HVT U4045 ( .A(AHB_I2C_WRAPPER_sl_rdata[25]), .Y(n4944) );
  INVX1_HVT U4046 ( .A(AHB_I2C_WRAPPER_sl_rdata[24]), .Y(n4945) );
  INVX1_HVT U4052 ( .A(AHB_I2C_WRAPPER_sl_rdata[22]), .Y(n4946) );
  INVX1_HVT U4061 ( .A(AHB_I2C_WRAPPER_sl_rdata[21]), .Y(n4947) );
  INVX1_HVT U4062 ( .A(AHB_I2C_WRAPPER_sl_rdata[20]), .Y(n4948) );
  INVX1_HVT U4065 ( .A(AHB_I2C_WRAPPER_sl_rdata[19]), .Y(n4949) );
  INVX1_HVT U4070 ( .A(AHB_I2C_WRAPPER_sl_rdata[18]), .Y(n4950) );
  INVX1_HVT U4074 ( .A(AHB_I2C_WRAPPER_sl_rdata[17]), .Y(n4951) );
  INVX1_HVT U4077 ( .A(AHB_I2C_WRAPPER_sl_rdata[9]), .Y(n4952) );
  INVX1_HVT U4078 ( .A(AHB_I2C_WRAPPER_sl_rdata[8]), .Y(n4953) );
  INVX1_HVT U4085 ( .A(AHB_SPI_WRAPPER_slave_select[0]), .Y(n4954) );
  INVX1_HVT U4086 ( .A(AHB_SPI_WRAPPER_tx_data[27]), .Y(n4955) );
  INVX1_HVT U4098 ( .A(AHB_SPI_WRAPPER_tx_data[23]), .Y(n4956) );
  INVX1_HVT U4101 ( .A(AHB_SPI_WRAPPER_tx_data[21]), .Y(n4957) );
  INVX1_HVT U4110 ( .A(AHB_SPI_WRAPPER_sl_rdata[27]), .Y(n4958) );
  INVX1_HVT U4114 ( .A(AHB_SPI_WRAPPER_sl_rdata[26]), .Y(n4959) );
  INVX1_HVT U4118 ( .A(AHB_SPI_WRAPPER_sl_rdata[25]), .Y(n4960) );
  INVX1_HVT U4119 ( .A(AHB_SPI_WRAPPER_sl_rdata[24]), .Y(n4961) );
  INVX1_HVT U4129 ( .A(AHB_SPI_WRAPPER_sl_rdata[23]), .Y(n4962) );
  INVX1_HVT U4130 ( .A(AHB_SPI_WRAPPER_sl_rdata[22]), .Y(n4963) );
  INVX1_HVT U4134 ( .A(AHB_SPI_WRAPPER_sl_rdata[21]), .Y(n4964) );
  INVX1_HVT U4135 ( .A(AHB_SPI_WRAPPER_sl_rdata[20]), .Y(n4965) );
  INVX1_HVT U4136 ( .A(AHB_SPI_WRAPPER_sl_rdata[19]), .Y(n4966) );
  INVX1_HVT U4139 ( .A(AHB_SPI_WRAPPER_sl_rdata[18]), .Y(n4967) );
  INVX1_HVT U4140 ( .A(AHB_SPI_WRAPPER_sl_rdata[17]), .Y(n4968) );
  INVX1_HVT U4145 ( .A(AHB_SPI_WRAPPER_sl_rdata[16]), .Y(n4969) );
  INVX1_HVT U4163 ( .A(AHB_SPI_WRAPPER_sl_rdata[15]), .Y(n4970) );
  INVX1_HVT U4164 ( .A(AHB_SPI_WRAPPER_sl_rdata[14]), .Y(n4971) );
  INVX1_HVT U4168 ( .A(AHB_SPI_WRAPPER_sl_rdata[13]), .Y(n4972) );
  INVX1_HVT U4169 ( .A(AHB_SPI_WRAPPER_sl_rdata[12]), .Y(n4973) );
  INVX1_HVT U4191 ( .A(AHB_SPI_WRAPPER_sl_rdata[11]), .Y(n4974) );
  INVX1_HVT U4192 ( .A(AHB_SPI_WRAPPER_sl_rdata[10]), .Y(n4975) );
  INVX1_HVT U4206 ( .A(AHB_SPI_WRAPPER_sl_rdata[9]), .Y(n4976) );
  INVX1_HVT U4222 ( .A(AHB_UART_WRAPPER_tx_data[25]), .Y(n4977) );
  INVX1_HVT U4267 ( .A(AHB_UART_WRAPPER_tx_data[24]), .Y(n4978) );
  INVX1_HVT U4268 ( .A(AHB_UART_WRAPPER_tx_data[23]), .Y(n4979) );
  INVX1_HVT U4280 ( .A(AHB_UART_WRAPPER_tx_data[21]), .Y(n4980) );
  INVX1_HVT U4283 ( .A(AHB_UART_WRAPPER_tx_data[20]), .Y(n4981) );
  INVX1_HVT U4334 ( .A(AHB_UART_WRAPPER_tx_data[19]), .Y(n4982) );
  INVX1_HVT U4342 ( .A(AHB_UART_WRAPPER_tx_data[17]), .Y(n4983) );
  INVX1_HVT U4350 ( .A(AHB_UART_WRAPPER_tx_data[14]), .Y(n4984) );
  INVX1_HVT U4358 ( .A(n5481), .Y(n4985) );
  INVX1_HVT U4366 ( .A(n5482), .Y(n4986) );
  INVX1_HVT U4367 ( .A(n5480), .Y(n4987) );
  INVX1_HVT U4373 ( .A(n5479), .Y(n4988) );
  INVX1_HVT U4380 ( .A(n5477), .Y(n4989) );
  INVX1_HVT U4382 ( .A(n5478), .Y(n4990) );
  INVX1_HVT U4396 ( .A(AHB_UART_WRAPPER_sl_rdata[25]), .Y(n4991) );
  INVX1_HVT U4399 ( .A(AHB_UART_WRAPPER_sl_rdata[24]), .Y(n4992) );
  INVX1_HVT U4400 ( .A(AHB_UART_WRAPPER_sl_rdata[23]), .Y(n4993) );
  INVX1_HVT U4401 ( .A(AHB_UART_WRAPPER_sl_rdata[22]), .Y(n4994) );
  INVX1_HVT U4402 ( .A(AHB_UART_WRAPPER_sl_rdata[21]), .Y(n4995) );
  INVX1_HVT U4403 ( .A(AHB_UART_WRAPPER_sl_rdata[20]), .Y(n4996) );
  INVX1_HVT U4404 ( .A(AHB_UART_WRAPPER_sl_rdata[19]), .Y(n4997) );
  INVX1_HVT U4405 ( .A(AHB_UART_WRAPPER_sl_rdata[18]), .Y(n4998) );
  INVX1_HVT U4406 ( .A(AHB_UART_WRAPPER_sl_rdata[17]), .Y(n4999) );
  INVX1_HVT U4407 ( .A(AHB_UART_WRAPPER_sl_rdata[16]), .Y(n5000) );
  INVX1_HVT U4408 ( .A(AHB_UART_WRAPPER_sl_rdata[15]), .Y(n5001) );
  INVX1_HVT U4409 ( .A(AHB_UART_WRAPPER_sl_rdata[14]), .Y(n5002) );
  INVX1_HVT U4410 ( .A(AHB_UART_WRAPPER_sl_rdata[13]), .Y(n5003) );
  INVX1_HVT U4411 ( .A(AHB_UART_WRAPPER_sl_rdata[12]), .Y(n5004) );
  INVX1_HVT U4412 ( .A(AHB_UART_WRAPPER_sl_rdata[11]), .Y(n5005) );
  INVX1_HVT U4413 ( .A(AHB_UART_WRAPPER_sl_rdata[10]), .Y(n5006) );
  INVX1_HVT U4414 ( .A(AHB_UART_WRAPPER_sl_rdata[9]), .Y(n5007) );
  INVX1_HVT U4415 ( .A(AHB_UART_WRAPPER_sl_rdata[8]), .Y(n5008) );
  INVX1_HVT U4416 ( .A(AHB_UART_WRAPPER_sl_rdata[7]), .Y(n5009) );
  INVX2_HVT U4417 ( .A(AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_STATE[2]), 
        .Y(n5010) );
  INVX2_HVT U4418 ( .A(AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_STATE[1]), 
        .Y(n5011) );
  INVX1_HVT U4420 ( .A(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter[1]), .Y(
        n5013) );
  INVX1_HVT U4421 ( .A(n5470), .Y(n5014) );
  INVX1_HVT U4422 ( .A(n5509), .Y(n5015) );
  INVX2_HVT U4423 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[2]), .Y(n5016) );
  INVX1_HVT U4424 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[0]), .Y(n5017) );
  INVX1_HVT U4425 ( .A(n5454), .Y(n5018) );
  INVX1_HVT U4426 ( .A(n5340), .Y(n5019) );
  INVX1_HVT U4427 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_rw_mode), .Y(n5020) );
  INVX1_HVT U4428 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[13]), .Y(n5021)
         );
  INVX1_HVT U4429 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[12]), .Y(n5022)
         );
  INVX1_HVT U4430 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[11]), .Y(n5023)
         );
  INVX1_HVT U4431 ( .A(n5341), .Y(n5024) );
  INVX1_HVT U4432 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[5]), .Y(n5025)
         );
  INVX1_HVT U4433 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[4]), .Y(n5026)
         );
  INVX1_HVT U4434 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[3]), .Y(n5027)
         );
  INVX1_HVT U4435 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[2]), .Y(n5028)
         );
  INVX1_HVT U4436 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[1]), .Y(n5029)
         );
  INVX1_HVT U4437 ( .A(AHB_SPI_WRAPPER_SPI_CONTROLLER_STATE[1]), .Y(n5030) );
  INVX4_HVT U4438 ( .A(AHB_SPI_WRAPPER_SPI_CONTROLLER_STATE[0]), .Y(n5031) );
  NBUFFX32_HVT U4439 ( .A(AHB_SRAM_WRAPPER_sl_addr[7]), .Y(n5032) );
  NBUFFX8_HVT U4440 ( .A(AHB_SRAM_WRAPPER_sl_addr[6]), .Y(n5033) );
  NBUFFX8_HVT U4441 ( .A(AHB_SRAM_WRAPPER_sl_addr[6]), .Y(n5034) );
  NBUFFX8_HVT U4442 ( .A(AHB_SRAM_WRAPPER_sl_addr[5]), .Y(n5035) );
  NBUFFX8_HVT U4443 ( .A(AHB_SRAM_WRAPPER_sl_addr[5]), .Y(n5036) );
  NBUFFX32_HVT U4444 ( .A(AHB_SRAM_WRAPPER_sl_addr[4]), .Y(n5037) );
  NBUFFX8_HVT U4445 ( .A(n5039), .Y(n5038) );
  NBUFFX8_HVT U4446 ( .A(AHB_SRAM_WRAPPER_sl_addr[3]), .Y(n5039) );
  NBUFFX8_HVT U4447 ( .A(AHB_SRAM_WRAPPER_sl_addr[2]), .Y(n5040) );
  NBUFFX8_HVT U4449 ( .A(AHB_SRAM_WRAPPER_sl_addr[1]), .Y(n5042) );
  NBUFFX8_HVT U4451 ( .A(AHB_SRAM_WRAPPER_sl_addr[0]), .Y(n5044) );
  NBUFFX8_HVT U4453 ( .A(AHB_SRAM_WRAPPER_sl_write), .Y(n5046) );
  NBUFFX32_HVT U4454 ( .A(AHB_SRAM_WRAPPER_sl_write), .Y(n5047) );
  NBUFFX32_HVT U4455 ( .A(AHB_SRAM_WRAPPER_sl_wdata[31]), .Y(n5048) );
  NBUFFX32_HVT U4456 ( .A(AHB_SRAM_WRAPPER_sl_wdata[30]), .Y(n5049) );
  NBUFFX32_HVT U4457 ( .A(AHB_SRAM_WRAPPER_sl_wdata[29]), .Y(n5050) );
  NBUFFX32_HVT U4458 ( .A(AHB_SRAM_WRAPPER_sl_wdata[28]), .Y(n5051) );
  NBUFFX32_HVT U4459 ( .A(AHB_SRAM_WRAPPER_sl_wdata[27]), .Y(n5052) );
  NBUFFX32_HVT U4460 ( .A(AHB_SRAM_WRAPPER_sl_wdata[26]), .Y(n5053) );
  NBUFFX8_HVT U4467 ( .A(AHB_SRAM_WRAPPER_sl_wdata[19]), .Y(n5060) );
  NBUFFX8_HVT U4468 ( .A(AHB_SRAM_WRAPPER_sl_wdata[19]), .Y(n5061) );
  NBUFFX32_HVT U4469 ( .A(AHB_SRAM_WRAPPER_sl_wdata[18]), .Y(n5062) );
  NBUFFX8_HVT U4470 ( .A(AHB_SRAM_WRAPPER_sl_wdata[17]), .Y(n5063) );
  NBUFFX8_HVT U4471 ( .A(AHB_SRAM_WRAPPER_sl_wdata[17]), .Y(n5064) );
  NBUFFX8_HVT U4472 ( .A(AHB_SRAM_WRAPPER_sl_wdata[16]), .Y(n5065) );
  NBUFFX8_HVT U4473 ( .A(AHB_SRAM_WRAPPER_sl_wdata[16]), .Y(n5066) );
  NBUFFX8_HVT U4474 ( .A(AHB_SRAM_WRAPPER_sl_wdata[15]), .Y(n5067) );
  NBUFFX32_HVT U4475 ( .A(AHB_SRAM_WRAPPER_sl_wdata[15]), .Y(n5068) );
  NBUFFX8_HVT U4476 ( .A(AHB_SRAM_WRAPPER_sl_wdata[14]), .Y(n5069) );
  NBUFFX8_HVT U4477 ( .A(AHB_SRAM_WRAPPER_sl_wdata[14]), .Y(n5070) );
  NBUFFX8_HVT U4478 ( .A(AHB_SRAM_WRAPPER_sl_wdata[13]), .Y(n5071) );
  NBUFFX32_HVT U4479 ( .A(AHB_SRAM_WRAPPER_sl_wdata[13]), .Y(n5072) );
  NBUFFX8_HVT U4480 ( .A(AHB_SRAM_WRAPPER_sl_wdata[12]), .Y(n5073) );
  NBUFFX8_HVT U4481 ( .A(AHB_SRAM_WRAPPER_sl_wdata[12]), .Y(n5074) );
  NBUFFX32_HVT U4482 ( .A(AHB_SRAM_WRAPPER_sl_wdata[11]), .Y(n5075) );
  NBUFFX8_HVT U4483 ( .A(AHB_SRAM_WRAPPER_sl_wdata[10]), .Y(n5076) );
  NBUFFX32_HVT U4484 ( .A(AHB_SRAM_WRAPPER_sl_wdata[10]), .Y(n5077) );
  NBUFFX8_HVT U4485 ( .A(AHB_SRAM_WRAPPER_sl_wdata[9]), .Y(n5078) );
  NBUFFX32_HVT U4486 ( .A(AHB_SRAM_WRAPPER_sl_wdata[9]), .Y(n5079) );
  NBUFFX8_HVT U4487 ( .A(AHB_SRAM_WRAPPER_sl_wdata[8]), .Y(n5080) );
  NBUFFX32_HVT U4488 ( .A(AHB_SRAM_WRAPPER_sl_wdata[8]), .Y(n5081) );
  NBUFFX8_HVT U4490 ( .A(AHB_SRAM_WRAPPER_sl_wdata[6]), .Y(n5083) );
  NBUFFX8_HVT U4491 ( .A(AHB_SRAM_WRAPPER_sl_wdata[6]), .Y(n5084) );
  NBUFFX32_HVT U4492 ( .A(AHB_SRAM_WRAPPER_sl_wdata[5]), .Y(n5085) );
  NBUFFX32_HVT U4493 ( .A(AHB_SRAM_WRAPPER_sl_wdata[4]), .Y(n5086) );
  NBUFFX32_HVT U4494 ( .A(AHB_SRAM_WRAPPER_sl_wdata[3]), .Y(n5087) );
  NBUFFX32_HVT U4495 ( .A(AHB_SRAM_WRAPPER_sl_wdata[2]), .Y(n5088) );
  NBUFFX32_HVT U4496 ( .A(AHB_SRAM_WRAPPER_sl_wdata[1]), .Y(n5089) );
  NBUFFX32_HVT U4497 ( .A(AHB_SRAM_WRAPPER_sl_wdata[0]), .Y(n5090) );
  INVX8_HVT U4498 ( .A(n5435), .Y(n5091) );
  INVX8_HVT U4563 ( .A(n5510), .Y(n5093) );
  INVX4_HVT U4564 ( .A(n4744), .Y(n5094) );
  INVX8_HVT U4567 ( .A(n4744), .Y(n5095) );
  NBUFFX4_HVT U4568 ( .A(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[31]), 
        .Y(n5096) );
  NBUFFX4_HVT U4569 ( .A(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[29]), 
        .Y(n5097) );
  NBUFFX4_HVT U4571 ( .A(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[31]), 
        .Y(n5098) );
  NBUFFX4_HVT U4611 ( .A(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[30]), 
        .Y(n5099) );
  NBUFFX4_HVT U4612 ( .A(AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[29]), 
        .Y(n5100) );
  INVX1_HVT U4616 ( .A(n3612), .Y(n5101) );
  INVX8_HVT U4620 ( .A(n5501), .Y(n5102) );
  INVX4_HVT U4624 ( .A(n4522), .Y(n5103) );
  INVX1_HVT U4632 ( .A(n5530), .Y(n5105) );
  INVX8_HVT U4636 ( .A(n3994), .Y(n5106) );
  INVX4_HVT U4640 ( .A(n3889), .Y(n5107) );
  INVX1_HVT U4641 ( .A(n4372), .Y(n5108) );
  INVX1_HVT U4644 ( .A(n3462), .Y(n5109) );
  INVX8_HVT U4652 ( .A(n4591), .Y(n5111) );
  INVX1_HVT U4653 ( .A(n4281), .Y(n5112) );
  INVX1_HVT U4654 ( .A(n5268), .Y(n5113) );
  NBUFFX32_HVT U4655 ( .A(AHB_SRAM_WRAPPER_SRAM_CONTROLLER__0_net_), .Y(n5114)
         );
  INVX4_HVT U4658 ( .A(n4223), .Y(n5115) );
  INVX1_HVT U4662 ( .A(n3575), .Y(n5116) );
  INVX2_HVT U4663 ( .A(n3573), .Y(n5117) );
  INVX2_HVT U4666 ( .A(n4412), .Y(n5118) );
  INVX2_HVT U4667 ( .A(n4374), .Y(n5119) );
  INVX4_HVT U4670 ( .A(n4368), .Y(n5120) );
  INVX2_HVT U4671 ( .A(n4547), .Y(n5121) );
  INVX1_HVT U4674 ( .A(n3953), .Y(n5122) );
  INVX1_HVT U4675 ( .A(n3950), .Y(n5123) );
  INVX1_HVT U4679 ( .A(n5511), .Y(n5124) );
  INVX1_HVT U4680 ( .A(n3730), .Y(n5125) );
  INVX1_HVT U4683 ( .A(n4262), .Y(n5126) );
  INVX1_HVT U4684 ( .A(n4398), .Y(n5127) );
  INVX1_HVT U4687 ( .A(n3412), .Y(n5128) );
  INVX1_HVT U4688 ( .A(n5500), .Y(n5129) );
  INVX1_HVT U4691 ( .A(n4406), .Y(n5130) );
  NBUFFX2_HVT U4695 ( .A(n4366), .Y(n5131) );
  INVX2_HVT U4699 ( .A(n4396), .Y(n5132) );
  INVX4_HVT U4702 ( .A(n3710), .Y(n5133) );
  NBUFFX4_HVT U4705 ( .A(n4101), .Y(n5134) );
  NBUFFX4_HVT U4708 ( .A(n3411), .Y(n5135) );
  NBUFFX8_HVT U4710 ( .A(n3411), .Y(n5136) );
  INVX1_HVT U4719 ( .A(n4471), .Y(n5137) );
  NBUFFX4_HVT U4725 ( .A(n3304), .Y(n5139) );
  NBUFFX4_HVT U4726 ( .A(n3284), .Y(n5140) );
  NBUFFX4_HVT U4731 ( .A(n3200), .Y(n5141) );
  NBUFFX4_HVT U4734 ( .A(n3125), .Y(n5142) );
  NBUFFX4_HVT U4735 ( .A(n3108), .Y(n5143) );
  NBUFFX4_HVT U4774 ( .A(n3097), .Y(n5144) );
  NBUFFX4_HVT U4775 ( .A(n3033), .Y(n5145) );
  NBUFFX4_HVT U4778 ( .A(n2884), .Y(n5146) );
  NBUFFX4_HVT U4779 ( .A(n2875), .Y(n5147) );
  NBUFFX4_HVT U4782 ( .A(n2841), .Y(n5148) );
  NBUFFX2_HVT U4785 ( .A(n3100), .Y(n5149) );
  INVX2_HVT U4788 ( .A(n4452), .Y(n5150) );
  INVX2_HVT U4791 ( .A(n4449), .Y(n5151) );
  INVX1_HVT U4797 ( .A(n4447), .Y(n5153) );
  INVX2_HVT U4800 ( .A(n4226), .Y(n5154) );
  INVX1_HVT U4801 ( .A(n5281), .Y(n5155) );
  INVX1_HVT U4804 ( .A(n4370), .Y(n5156) );
  NBUFFX4_HVT U4807 ( .A(n3318), .Y(n5157) );
  NBUFFX4_HVT U4810 ( .A(n3158), .Y(n5158) );
  NBUFFX4_HVT U4812 ( .A(n2882), .Y(n5159) );
  NBUFFX2_HVT U4813 ( .A(n3165), .Y(n5160) );
  NBUFFX2_HVT U4816 ( .A(n3101), .Y(n5161) );
  NBUFFX2_HVT U4818 ( .A(n3039), .Y(n5162) );
  NBUFFX2_HVT U4819 ( .A(n3018), .Y(n5163) );
  NBUFFX2_HVT U4821 ( .A(n2996), .Y(n5164) );
  NBUFFX2_HVT U4824 ( .A(n2848), .Y(n5165) );
  NBUFFX2_HVT U4827 ( .A(n2849), .Y(n5166) );
  INVX2_HVT U4830 ( .A(n5388), .Y(n5167) );
  NBUFFX4_HVT U4831 ( .A(n4401), .Y(n5168) );
  INVX1_HVT U4833 ( .A(n5168), .Y(n5169) );
  INVX2_HVT U4842 ( .A(n5483), .Y(n5170) );
  NBUFFX4_HVT U4854 ( .A(n3507), .Y(n5171) );
  INVX2_HVT U4855 ( .A(n5171), .Y(n5172) );
  NBUFFX8_HVT U4859 ( .A(n3507), .Y(n5173) );
  INVX2_HVT U4860 ( .A(n5173), .Y(n5174) );
  NBUFFX8_HVT U4878 ( .A(n3507), .Y(n5175) );
  INVX1_HVT U4879 ( .A(n5175), .Y(n5176) );
  NBUFFX4_HVT U4881 ( .A(n3507), .Y(n5177) );
  NBUFFX4_HVT U4886 ( .A(n3642), .Y(n5179) );
  INVX1_HVT U4891 ( .A(n5179), .Y(n5180) );
  NBUFFX32_HVT U4892 ( .A(n3586), .Y(n5181) );
  NBUFFX8_HVT U4897 ( .A(n3586), .Y(n5182) );
  INVX16_HVT U4903 ( .A(n4529), .Y(n5183) );
  NBUFFX2_HVT U4905 ( .A(n4529), .Y(n5184) );
  INVX8_HVT U4906 ( .A(n5184), .Y(n5185) );
  NBUFFX32_HVT U4907 ( .A(n5187), .Y(n5186) );
  NBUFFX8_HVT U4910 ( .A(n3581), .Y(n5187) );
  NBUFFX32_HVT U4913 ( .A(n3590), .Y(n5188) );
  NBUFFX8_HVT U4918 ( .A(n3590), .Y(n5189) );
  NBUFFX8_HVT U4921 ( .A(n3590), .Y(n5190) );
  INVX1_HVT U4924 ( .A(n4344), .Y(n5191) );
  NBUFFX2_HVT U4930 ( .A(n2522), .Y(n5192) );
  INVX1_HVT U4933 ( .A(n4356), .Y(n5193) );
  INVX8_HVT U4936 ( .A(n4528), .Y(n5194) );
  INVX16_HVT U4937 ( .A(n4204), .Y(n5195) );
  INVX2_HVT U4939 ( .A(n4320), .Y(n5196) );
  INVX2_HVT U4940 ( .A(n4220), .Y(n5197) );
  NBUFFX4_HVT U4942 ( .A(n4425), .Y(n5198) );
  INVX1_HVT U4943 ( .A(n5198), .Y(n5199) );
  AND4X4_HVT U3032 ( .A1(n4610), .A2(n4613), .A3(n4611), .A4(n4612), .Y(n2797)
         );
  AND4X4_HVT U3075 ( .A1(AHB_SRAM_WRAPPER_sl_addr[11]), .A2(
        AHB_SRAM_WRAPPER_sl_addr[9]), .A3(n4611), .A4(n4613), .Y(n2816) );
  AND4X4_HVT U3023 ( .A1(AHB_SRAM_WRAPPER_sl_addr[8]), .A2(
        AHB_SRAM_WRAPPER_sl_addr[9]), .A3(n4610), .A4(n4611), .Y(n2791) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_STATE_reg_2_ ( .D(
        n1874), .CLK(HCLK), .RSTB(n4884), .Q(n5287), .QN(n4741) );
  OA21X2_HVT U3846 ( .A1(sram_readyout), .A2(n3451), .A3(n4063), .Y(HREADY) );
  DFFARX2_HVT AHB_DECMUX_mux_select_reg_0_ ( .D(n2455), .CLK(HCLK), .RSTB(
        n4885), .QN(n4744) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_bit_counter_reg_0_ ( .D(n2081), 
        .CLK(HCLK), .RSTB(n4906), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_bit_counter[0]), .QN(n4711) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter_reg_1_ ( 
        .D(n1870), .CLK(HCLK), .RSTB(n4900), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter[1]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_STATE_reg_0_ ( .D(n2142), .CLK(
        HCLK), .RSTB(n4906), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_STATE[0]) );
  TNBUFFX4_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_SDA_tri ( .A(1'b0), .EN(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_SDA_PULLDOWN), .Y(I2C_SDA) );
  NAND3X2_HVT U3886 ( .A1(n4390), .A2(n4372), .A3(n3462), .Y(n4359) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_bit_counter_reg_2_ ( .D(n2079), 
        .CLK(HCLK), .RSTB(n4906), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_bit_counter[2]), .QN(n4710) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_counter_reg_1_ ( .D(n1929), 
        .CLK(HCLK), .RSTB(n4901), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_counter[1]), .QN(n4724) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_counter_reg_0_ ( .D(n2139), 
        .CLK(HCLK), .RSTB(n4906), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_counter[0]), .QN(n4669) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg_reg_8_ ( .D(n2410), .CLK(
        HCLK), .RSTB(n4910), .Q(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[8]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter_reg_0_ ( .D(n2082), 
        .CLK(HCLK), .RSTB(n4906), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter[0]), .QN(n4709) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_counter_reg_1_ ( .D(n2140), 
        .CLK(HCLK), .RSTB(n4906), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_counter[1]), .QN(n4667) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_counter_reg_0_ ( .D(n1930), 
        .CLK(HCLK), .RSTB(n4901), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_counter[0]), .QN(n4725) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg_reg_7_ ( .D(n2411), .CLK(
        HCLK), .RSTB(n4914), .Q(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[7]) );
  OA222X2_HVT U5496 ( .A1(n4550), .A2(AHB_SPI_WRAPPER_spi_start), .A3(n4550), 
        .A4(AHB_SPI_WRAPPER_slave_select[0]), .A5(n4550), .A6(n5031), .Y(n4551) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame_reg_4_ ( 
        .D(n1862), .CLK(HCLK), .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[4]) );
  OA222X2_HVT U5494 ( .A1(n4550), .A2(AHB_SPI_WRAPPER_spi_start), .A3(n4550), 
        .A4(n5031), .A5(n4550), .A6(n4954), .Y(n4548) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame_reg_3_ ( 
        .D(n1863), .CLK(HCLK), .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[3]) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_0_ ( .D(n2342), .CLK(
        HCLK), .RSTB(n4904), .Q(AHB_UART_WRAPPER_sl_wdata[0]) );
  MUX21X2_HVT U4041 ( .A1(n3522), .A2(n3521), .S0(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_size[2]), .Y(n4379) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_3_ ( .D(n2339), .CLK(
        HCLK), .RSTB(n4886), .Q(AHB_UART_WRAPPER_sl_wdata[3]) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_addr_reg_reg_3_ ( .D(n2343), .CLK(
        HCLK), .RSTB(n4888), .Q(AHB_UART_WRAPPER_AHB_UART_SUB_addr_reg[3]) );
  OA221X2_HVT U3788 ( .A1(n3420), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_size[2]), .A3(n3420), .A4(n3419), 
        .A5(n4399), .Y(n4406) );
  OA221X2_HVT U5245 ( .A1(n4306), .A2(n4305), .A3(n4306), .A4(n4304), .A5(
        n5135), .Y(n4307) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_STATE_reg_1_ ( .D(
        n1857), .CLK(HCLK), .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_STATE[1]) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_30_ ( .D(n2312), 
        .CLK(HCLK), .RSTB(n4888), .Q(AHB_UART_WRAPPER_sl_wdata[30]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_3_ ( .D(n5192), .CLK(HCLK), 
        .RSTB(n4896), .Q(AHB_I2C_WRAPPER_sl_rdata[3]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame_reg_5_ ( 
        .D(n1861), .CLK(HCLK), .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[5]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_addr_reg_reg_3_ ( .D(n2255), .CLK(
        HCLK), .RSTB(n4905), .Q(AHB_SPI_WRAPPER_AHB_SPI_SUB_addr_reg[3]) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_addr_reg_reg_2_ ( .D(n2344), .CLK(
        HCLK), .RSTB(n4902), .Q(AHB_UART_WRAPPER_AHB_UART_SUB_addr_reg[2]) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_27_ ( .D(n2379), 
        .CLK(HCLK), .RSTB(n4888), .Q(AHB_SRAM_WRAPPER_sl_wdata[27]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_7_ ( .D(n2591), .CLK(HCLK), 
        .RSTB(n4897), .Q(AHB_SPI_WRAPPER_sl_rdata[7]) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_31_ ( .D(n2311), 
        .CLK(HCLK), .RSTB(n4888), .Q(AHB_UART_WRAPPER_sl_wdata[31]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_size_reg_1_ ( .D(n1938), .CLK(
        HCLK), .RSTB(n4901), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_size[1]) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_29_ ( .D(n2377), 
        .CLK(HCLK), .RSTB(n4902), .Q(AHB_SRAM_WRAPPER_sl_wdata[29]) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_29_ ( .D(n2313), 
        .CLK(HCLK), .RSTB(n4902), .Q(AHB_UART_WRAPPER_sl_wdata[29]) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_26_ ( .D(n2380), 
        .CLK(HCLK), .RSTB(n4888), .Q(AHB_SRAM_WRAPPER_sl_wdata[26]) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_26_ ( .D(n2316), 
        .CLK(HCLK), .RSTB(n4889), .Q(AHB_UART_WRAPPER_sl_wdata[26]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_addr_reg_reg_1_ ( .D(n2257), .CLK(
        HCLK), .RSTB(n4905), .Q(AHB_SPI_WRAPPER_AHB_SPI_SUB_addr_reg[1]) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_18_ ( .D(n2388), 
        .CLK(HCLK), .RSTB(n4886), .Q(AHB_SRAM_WRAPPER_sl_wdata[18]) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_27_ ( .D(n2315), 
        .CLK(HCLK), .RSTB(n4904), .Q(AHB_UART_WRAPPER_sl_wdata[27]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_STATE_reg_2_ ( .D(
        n1856), .CLK(HCLK), .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_STATE[2]) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg_reg_2_ ( .D(n2416), .CLK(
        HCLK), .RSTB(n4905), .Q(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[2]) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_6_ ( .D(n2336), .CLK(
        HCLK), .RSTB(n4886), .Q(AHB_UART_WRAPPER_sl_wdata[6]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter_reg_0_ ( 
        .D(n1869), .CLK(HCLK), .RSTB(n4900), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter[0]), .QN(
        n4732) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_11_ ( .D(n2395), 
        .CLK(HCLK), .RSTB(n4886), .Q(AHB_SRAM_WRAPPER_sl_wdata[11]) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_28_ ( .D(n2378), 
        .CLK(HCLK), .RSTB(n4888), .Q(AHB_SRAM_WRAPPER_sl_wdata[28]) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_5_ ( .D(n2337), .CLK(
        HCLK), .RSTB(n4886), .Q(AHB_UART_WRAPPER_sl_wdata[5]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_size_reg_0_ ( .D(n1939), .CLK(
        HCLK), .RSTB(n4901), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_size[0]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame_reg_6_ ( 
        .D(n1860), .CLK(HCLK), .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[6]) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_30_ ( .D(n2376), 
        .CLK(HCLK), .RSTB(n4888), .Q(AHB_SRAM_WRAPPER_sl_wdata[30]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_2_ ( .D(n2596), .CLK(HCLK), 
        .RSTB(n4893), .Q(AHB_SPI_WRAPPER_sl_rdata[2]), .QN(n4626) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame_reg_2_ ( 
        .D(n1864), .CLK(HCLK), .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[2]) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_31_ ( .D(n2375), 
        .CLK(HCLK), .RSTB(n4888), .Q(AHB_SRAM_WRAPPER_sl_wdata[31]) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg_reg_1_ ( .D(n2417), .CLK(
        HCLK), .RSTB(n4905), .Q(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[1]) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_25_ ( .D(n2317), 
        .CLK(HCLK), .RSTB(n4904), .Q(AHB_UART_WRAPPER_sl_wdata[25]) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_3_ ( .D(n2403), .CLK(
        HCLK), .RSTB(n4886), .Q(AHB_SRAM_WRAPPER_sl_wdata[3]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame_reg_7_ ( 
        .D(n1859), .CLK(HCLK), .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[7]) );
  MUX41X2_HVT U5542 ( .A1(sram_rdata[31]), .A3(spi_rdata[31]), .A2(
        uart_rdata[31]), .A4(i2c_rdata[31]), .S0(n5092), .S1(n5094), .Y(
        HRDATA[31]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_rx_byte_size_reg_1_ ( .D(n2492), .CLK(
        HCLK), .RSTB(n4908), .Q(AHB_I2C_WRAPPER_rx_byte_size[1]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_size_reg_1_ ( .D(n1956), .CLK(
        HCLK), .RSTB(n4896), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_size[1]) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_2_ ( .D(n2404), .CLK(
        HCLK), .RSTB(n4886), .Q(AHB_SRAM_WRAPPER_sl_wdata[2]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_0_ ( .D(n2598), .CLK(HCLK), 
        .RSTB(n4893), .Q(AHB_SPI_WRAPPER_sl_rdata[0]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_size_reg_0_ ( .D(n1957), .CLK(
        HCLK), .RSTB(n4896), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_size[0]) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_24_ ( .D(n2318), 
        .CLK(HCLK), .RSTB(n4904), .Q(AHB_UART_WRAPPER_sl_wdata[24]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_STATE_reg_0_ ( .D(
        n1858), .CLK(HCLK), .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_STATE[0]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_rx_byte_size_reg_0_ ( .D(n2493), .CLK(
        HCLK), .RSTB(n4908), .Q(AHB_I2C_WRAPPER_rx_byte_size[0]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame_reg_1_ ( 
        .D(n1865), .CLK(HCLK), .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[1]) );
  MUX41X2_HVT U5543 ( .A1(sram_rdata[30]), .A3(spi_rdata[30]), .A2(
        uart_rdata[30]), .A4(i2c_rdata[30]), .S0(n5092), .S1(n5094), .Y(
        HRDATA[30]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_addr_reg_reg_0_ ( .D(n2258), .CLK(
        HCLK), .RSTB(n4894), .Q(AHB_SPI_WRAPPER_AHB_SPI_SUB_addr_reg[0]) );
  MUX41X2_HVT U5545 ( .A1(sram_rdata[28]), .A3(spi_rdata[28]), .A2(
        uart_rdata[28]), .A4(i2c_rdata[28]), .S0(n5092), .S1(n5094), .Y(
        HRDATA[28]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte_reg_2_ ( .D(n1923), .CLK(
        HCLK), .RSTB(n4903), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[2]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rw_mode_reg ( .D(n1954), .CLK(
        HCLK), .RSTB(n4912), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_rw_mode) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_22_ ( .D(n2320), 
        .CLK(HCLK), .RSTB(n4886), .Q(AHB_UART_WRAPPER_sl_wdata[22]) );
  NAND3X2_HVT U4339 ( .A1(n4305), .A2(n4301), .A3(n5115), .Y(n4226) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE_reg_2_ ( .D(n1933), .CLK(
        HCLK), .RSTB(n4901), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[2]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_0_ ( .D(n2490), .CLK(HCLK), 
        .RSTB(n4912), .Q(AHB_I2C_WRAPPER_tx_data[0]) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_20_ ( .D(n2322), 
        .CLK(HCLK), .RSTB(n4909), .Q(AHB_UART_WRAPPER_sl_wdata[20]) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_12_ ( .D(n2330), 
        .CLK(HCLK), .RSTB(n4909), .Q(AHB_UART_WRAPPER_sl_wdata[12]) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_5_ ( .D(n2401), .CLK(
        HCLK), .RSTB(n4886), .Q(AHB_SRAM_WRAPPER_sl_wdata[5]) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_19_ ( .D(n2323), 
        .CLK(HCLK), .RSTB(n4909), .Q(AHB_UART_WRAPPER_sl_wdata[19]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter_reg_1_ ( .D(n2083), 
        .CLK(HCLK), .RSTB(n4906), .Q(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_tx_counter[1]), .QN(n4708) );
  INVX2_HVT U4794 ( .A(n4445), .Y(n5152) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_17_ ( .D(n2619), .CLK(HCLK), .RSTB(n4899), .Q(AHB_UART_WRAPPER_tx_data[17]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_23_ ( .D(n2613), .CLK(HCLK), .RSTB(n4899), .Q(AHB_UART_WRAPPER_tx_data[23]) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_23_ ( .D(n2319), 
        .CLK(HCLK), .RSTB(n4886), .Q(AHB_UART_WRAPPER_sl_wdata[23]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_wstrb_reg_reg_1_ ( .D(n2220), .CLK(
        HCLK), .RSTB(n4898), .Q(AHB_SPI_WRAPPER_AHB_SPI_SUB_wstrb_reg[1]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_addr_reg_reg_2_ ( .D(n2071), .CLK(
        HCLK), .RSTB(n4905), .Q(AHB_I2C_WRAPPER_AHB_I2C_SUB_addr_reg[2]) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_14_ ( .D(n2328), 
        .CLK(HCLK), .RSTB(n4909), .Q(AHB_UART_WRAPPER_sl_wdata[14]) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_11_ ( .D(n2331), 
        .CLK(HCLK), .RSTB(n4891), .Q(AHB_UART_WRAPPER_sl_wdata[11]) );
  OA221X2_HVT U5278 ( .A1(n4330), .A2(n4367), .A3(n4330), .A4(n4368), .A5(
        n4360), .Y(n4344) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_21_ ( .D(n2321), 
        .CLK(HCLK), .RSTB(n4909), .Q(AHB_UART_WRAPPER_sl_wdata[21]) );
  INVX2_HVT U4885 ( .A(n5177), .Y(n5178) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sel_reg_reg ( .D(n2365), .CLK(HCLK), .RSTB(n4898), .Q(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sel_reg) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_21_ ( .D(n2615), .CLK(HCLK), .RSTB(n4899), .Q(AHB_UART_WRAPPER_tx_data[21]) );
  NAND2X4_HVT U2928 ( .A1(n2756), .A2(n2788), .Y(n2732) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_wstrb_reg_reg_0_ ( .D(n2222), .CLK(
        HCLK), .RSTB(n4898), .Q(AHB_SPI_WRAPPER_AHB_SPI_SUB_wstrb_reg[0]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_24_ ( .D(n2612), .CLK(HCLK), .RSTB(n4899), .Q(AHB_UART_WRAPPER_tx_data[24]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame_reg_0_ ( 
        .D(n1866), .CLK(HCLK), .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[0]) );
  NAND2X4_HVT U4715 ( .A1(AHB_SPI_WRAPPER_valid_trans), .A2(n4622), .Y(n3889)
         );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte_reg_3_ ( .D(n1922), .CLK(
        HCLK), .RSTB(n4903), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[3]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_19_ ( .D(n2617), .CLK(HCLK), .RSTB(n4899), .Q(AHB_UART_WRAPPER_tx_data[19]) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_wstrb_reg_reg_0_ ( .D(n2374), 
        .CLK(HCLK), .RSTB(n4898), .Q(
        AHB_SRAM_WRAPPER_AHB_SRAM_SUB_wstrb_reg[0]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte_reg_1_ ( .D(n1924), .CLK(
        HCLK), .RSTB(n4903), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[1]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter_reg_1_ ( 
        .D(n1854), .CLK(HCLK), .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Bit_Counter[1]), .QN(
        n4734) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_14_ ( .D(n2622), .CLK(HCLK), .RSTB(n4899), .Q(AHB_UART_WRAPPER_tx_data[14]) );
  NAND2X4_HVT U3722 ( .A1(n4741), .A2(n3401), .Y(n4471) );
  NAND2X4_HVT U4573 ( .A1(n5111), .A2(n4741), .Y(n4593) );
  NAND2X4_HVT U3135 ( .A1(n5523), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[15]), .Y(n2857) );
  NAND2X4_HVT U3239 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[5]), .Y(n2944) );
  NAND2X4_HVT U3220 ( .A1(n5415), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[1]), .Y(n2929) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_8_ ( .D(n2246), .CLK(
        HCLK), .RSTB(n4891), .Q(AHB_SPI_WRAPPER_sl_wdata[8]) );
  NAND2X4_HVT U3459 ( .A1(n5517), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[13]), .Y(n3154) );
  NAND2X4_HVT U3375 ( .A1(n5523), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[23]), .Y(n3075) );
  NAND2X4_HVT U3622 ( .A1(n5517), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[6]), .Y(n3317) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_28_ ( .D(n2640), .CLK(
        HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_sl_rdata[28]) );
  NAND2X4_HVT U3256 ( .A1(n5523), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[25]), .Y(n2961) );
  NAND2X4_HVT U3260 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[25]), .Y(n2966) );
  NAND2X4_HVT U3705 ( .A1(n5523), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[14]), .Y(n3391) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_7_ ( .D(n2247), .CLK(
        HCLK), .RSTB(n4891), .Q(AHB_SPI_WRAPPER_sl_wdata[7]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_30_ ( .D(n2638), .CLK(
        HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_sl_rdata[30]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_31_ ( .D(n2637), .CLK(
        HCLK), .RSTB(n4887), .Q(AHB_UART_WRAPPER_sl_rdata[31]) );
  NAND2X4_HVT U3677 ( .A1(n5523), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[27]), .Y(n3367) );
  NAND2X4_HVT U3498 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[3]), .Y(n3192) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_29_ ( .D(n2639), .CLK(
        HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_sl_rdata[29]) );
  NAND2X4_HVT U3315 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[4]), .Y(n3022) );
  NAND2X4_HVT U3644 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[26]), .Y(n3339) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_3_ ( .D(n2251), .CLK(
        HCLK), .RSTB(n4886), .Q(AHB_SPI_WRAPPER_sl_wdata[3]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_26_ ( .D(n2642), .CLK(
        HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_sl_rdata[26]) );
  NAND2X4_HVT U3271 ( .A1(n5517), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[11]), .Y(n2980) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_27_ ( .D(n2641), .CLK(
        HCLK), .RSTB(n4900), .Q(AHB_UART_WRAPPER_sl_rdata[27]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_6_ ( .D(n2248), .CLK(
        HCLK), .RSTB(n4886), .Q(AHB_SPI_WRAPPER_sl_wdata[6]) );
  NAND2X4_HVT U3294 ( .A1(n5517), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[8]), .Y(n3000) );
  NAND2X4_HVT U3606 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[10]), .Y(n3299) );
  NAND2X4_HVT U3115 ( .A1(n5517), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[9]), .Y(n2845) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_23_ ( .D(n2645), .CLK(
        HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_sl_rdata[23]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_4_ ( .D(n2250), .CLK(
        HCLK), .RSTB(n4889), .Q(AHB_SPI_WRAPPER_sl_wdata[4]) );
  NAND2X4_HVT U3371 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[23]), .Y(n3070) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_25_ ( .D(n2643), .CLK(
        HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_sl_rdata[25]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_24_ ( .D(n2644), .CLK(
        HCLK), .RSTB(n4890), .Q(AHB_UART_WRAPPER_sl_rdata[24]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_2_ ( .D(n2252), .CLK(
        HCLK), .RSTB(n4886), .Q(AHB_SPI_WRAPPER_sl_wdata[2]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_22_ ( .D(n2646), .CLK(
        HCLK), .RSTB(n4887), .Q(AHB_UART_WRAPPER_sl_rdata[22]) );
  NAND2X4_HVT U3561 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[16]), .Y(n3258) );
  NAND2X4_HVT U3343 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[20]), .Y(n3046) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_20_ ( .D(n2648), .CLK(
        HCLK), .RSTB(n4900), .Q(AHB_UART_WRAPPER_sl_rdata[20]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_1_ ( .D(n2253), .CLK(
        HCLK), .RSTB(n4904), .Q(AHB_SPI_WRAPPER_sl_wdata[1]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_18_ ( .D(n2650), .CLK(
        HCLK), .RSTB(n4900), .Q(AHB_UART_WRAPPER_sl_rdata[18]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_0_ ( .D(n2254), .CLK(
        HCLK), .RSTB(n4904), .Q(AHB_SPI_WRAPPER_sl_wdata[0]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_10_ ( .D(n2244), .CLK(
        HCLK), .RSTB(n4891), .Q(AHB_SPI_WRAPPER_sl_wdata[10]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_21_ ( .D(n2647), .CLK(
        HCLK), .RSTB(n4887), .Q(AHB_UART_WRAPPER_sl_rdata[21]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_15_ ( .D(n2653), .CLK(
        HCLK), .RSTB(n4887), .Q(AHB_UART_WRAPPER_sl_rdata[15]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_17_ ( .D(n2651), .CLK(
        HCLK), .RSTB(n4900), .Q(AHB_UART_WRAPPER_sl_rdata[17]) );
  NAND2X4_HVT U3719 ( .A1(n4730), .A2(n4729), .Y(n4591) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_19_ ( .D(n2649), .CLK(
        HCLK), .RSTB(n4900), .Q(AHB_UART_WRAPPER_sl_rdata[19]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_15_ ( .D(n2239), .CLK(
        HCLK), .RSTB(n4886), .Q(AHB_SPI_WRAPPER_sl_wdata[15]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_9_ ( .D(n2245), .CLK(
        HCLK), .RSTB(n4891), .Q(AHB_SPI_WRAPPER_sl_wdata[9]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_4_ ( .D(n2664), .CLK(HCLK), .RSTB(n4887), .Q(AHB_UART_WRAPPER_sl_rdata[4]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_13_ ( .D(n2241), .CLK(
        HCLK), .RSTB(n4909), .Q(AHB_SPI_WRAPPER_sl_wdata[13]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_14_ ( .D(n2654), .CLK(
        HCLK), .RSTB(n4887), .Q(AHB_UART_WRAPPER_sl_rdata[14]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_16_ ( .D(n2652), .CLK(
        HCLK), .RSTB(n4887), .Q(AHB_UART_WRAPPER_sl_rdata[16]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_13_ ( .D(n2655), .CLK(
        HCLK), .RSTB(n4900), .Q(AHB_UART_WRAPPER_sl_rdata[13]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_3_ ( .D(n2665), .CLK(HCLK), .RSTB(n4887), .Q(AHB_UART_WRAPPER_sl_rdata[3]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_11_ ( .D(n2243), .CLK(
        HCLK), .RSTB(n4886), .Q(AHB_SPI_WRAPPER_sl_wdata[11]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_2_ ( .D(n2666), .CLK(HCLK), .RSTB(n4887), .Q(AHB_UART_WRAPPER_sl_rdata[2]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_17_ ( .D(n2237), .CLK(
        HCLK), .RSTB(n4909), .Q(AHB_SPI_WRAPPER_sl_wdata[17]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_18_ ( .D(n2236), .CLK(
        HCLK), .RSTB(n4886), .Q(AHB_SPI_WRAPPER_sl_wdata[18]) );
  TNBUFFX4_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_SCL_tri ( .A(1'b0), .EN(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_SCL_PULLDOWN), .Y(I2C_SCL) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_12_ ( .D(n2656), .CLK(
        HCLK), .RSTB(n4900), .Q(AHB_UART_WRAPPER_sl_rdata[12]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_14_ ( .D(n2240), .CLK(
        HCLK), .RSTB(n4904), .Q(AHB_SPI_WRAPPER_sl_wdata[14]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_22_ ( .D(n2232), .CLK(
        HCLK), .RSTB(n4904), .Q(AHB_SPI_WRAPPER_sl_wdata[22]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_12_ ( .D(n2242), .CLK(
        HCLK), .RSTB(n4909), .Q(AHB_SPI_WRAPPER_sl_wdata[12]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_5_ ( .D(n2663), .CLK(HCLK), .RSTB(n4887), .Q(AHB_UART_WRAPPER_sl_rdata[5]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_16_ ( .D(n2238), .CLK(
        HCLK), .RSTB(n4909), .Q(AHB_SPI_WRAPPER_sl_wdata[16]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_28_ ( .D(n2497), .CLK(HCLK), 
        .RSTB(n4912), .Q(AHB_I2C_WRAPPER_sl_rdata[28]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_11_ ( .D(n2657), .CLK(
        HCLK), .RSTB(n4900), .Q(AHB_UART_WRAPPER_sl_rdata[11]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_10_ ( .D(n2658), .CLK(
        HCLK), .RSTB(n4900), .Q(AHB_UART_WRAPPER_sl_rdata[10]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_20_ ( .D(n2234), .CLK(
        HCLK), .RSTB(n4904), .Q(AHB_SPI_WRAPPER_sl_wdata[20]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_9_ ( .D(n2659), .CLK(HCLK), .RSTB(n4900), .Q(AHB_UART_WRAPPER_sl_rdata[9]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_6_ ( .D(n2662), .CLK(HCLK), .RSTB(n4887), .Q(AHB_UART_WRAPPER_sl_rdata[6]) );
  OA21X2_HVT U3808 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[1]), .A2(n4374), 
        .A3(n4398), .Y(n4360) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_20_ ( .D(n2470), .CLK(HCLK), 
        .RSTB(n4899), .Q(AHB_I2C_WRAPPER_tx_data[20]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_7_ ( .D(n2661), .CLK(HCLK), .RSTB(n4900), .Q(AHB_UART_WRAPPER_sl_rdata[7]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_31_ ( .D(n2494), .CLK(HCLK), 
        .RSTB(n4908), .Q(AHB_I2C_WRAPPER_sl_rdata[31]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_8_ ( .D(n2660), .CLK(HCLK), .RSTB(n4900), .Q(AHB_UART_WRAPPER_sl_rdata[8]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_13_ ( .D(n2477), .CLK(HCLK), 
        .RSTB(n4886), .Q(AHB_I2C_WRAPPER_tx_data[13]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_30_ ( .D(n2495), .CLK(HCLK), 
        .RSTB(n4908), .Q(AHB_I2C_WRAPPER_sl_rdata[30]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_29_ ( .D(n2496), .CLK(HCLK), 
        .RSTB(n4888), .Q(AHB_I2C_WRAPPER_sl_rdata[29]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_22_ ( .D(n2468), .CLK(HCLK), 
        .RSTB(n4913), .Q(AHB_I2C_WRAPPER_tx_data[22]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_6_ ( .D(n2592), .CLK(HCLK), 
        .RSTB(n4897), .Q(AHB_SPI_WRAPPER_sl_rdata[6]) );
  NAND3X2_HVT U4341 ( .A1(n5531), .A2(
        AHB_SPI_WRAPPER_SPI_CONTROLLER_bit_counter[1]), .A3(n4677), .Y(n4262)
         );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_15_ ( .D(n2475), .CLK(HCLK), 
        .RSTB(n4891), .Q(AHB_I2C_WRAPPER_tx_data[15]) );
  OAI222X2_HVT U4968 ( .A1(n4653), .A2(n5491), .A3(n4942), .A4(n5106), .A5(
        n4918), .A6(n5533), .Y(n2498) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_23_ ( .D(n2467), .CLK(HCLK), 
        .RSTB(n4891), .Q(AHB_I2C_WRAPPER_tx_data[23]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_25_ ( .D(n2465), .CLK(HCLK), 
        .RSTB(n4891), .Q(AHB_I2C_WRAPPER_tx_data[25]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_24_ ( .D(n2230), .CLK(
        HCLK), .RSTB(n4904), .Q(AHB_SPI_WRAPPER_sl_wdata[24]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_25_ ( .D(n2229), .CLK(
        HCLK), .RSTB(n4902), .Q(AHB_SPI_WRAPPER_sl_wdata[25]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_19_ ( .D(n2471), .CLK(HCLK), 
        .RSTB(n4899), .Q(AHB_I2C_WRAPPER_tx_data[19]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_8_ ( .D(n2590), .CLK(HCLK), 
        .RSTB(n4897), .Q(AHB_SPI_WRAPPER_sl_rdata[8]) );
  OA22X2_HVT U5242 ( .A1(AHB_SPI_WRAPPER_tx_data[31]), .A2(n5459), .A3(n4299), 
        .A4(n5031), .Y(n4308) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg_reg_3_ ( .D(n2415), .CLK(
        HCLK), .RSTB(n4888), .Q(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[3]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_3_ ( .D(n2595), .CLK(HCLK), 
        .RSTB(n4897), .Q(AHB_SPI_WRAPPER_sl_rdata[3]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_31_ ( .D(n2223), .CLK(
        HCLK), .RSTB(n4888), .Q(AHB_SPI_WRAPPER_sl_wdata[31]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_30_ ( .D(n2224), .CLK(
        HCLK), .RSTB(n4888), .Q(AHB_SPI_WRAPPER_sl_wdata[30]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_5_ ( .D(n2485), .CLK(HCLK), 
        .RSTB(n4889), .Q(AHB_I2C_WRAPPER_tx_data[5]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_16_ ( .D(n2474), .CLK(HCLK), 
        .RSTB(n4891), .Q(AHB_I2C_WRAPPER_tx_data[16]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_26_ ( .D(n2228), .CLK(
        HCLK), .RSTB(n4888), .Q(AHB_SPI_WRAPPER_sl_wdata[26]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_2_ ( .D(n2488), .CLK(HCLK), 
        .RSTB(n4912), .Q(AHB_I2C_WRAPPER_tx_data[2]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_5_ ( .D(n2593), .CLK(HCLK), 
        .RSTB(n4897), .Q(AHB_SPI_WRAPPER_sl_rdata[5]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_28_ ( .D(n2226), .CLK(
        HCLK), .RSTB(n4888), .Q(AHB_SPI_WRAPPER_sl_wdata[28]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_26_ ( .D(n2499), .CLK(HCLK), 
        .RSTB(n4888), .Q(AHB_I2C_WRAPPER_sl_rdata[26]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_29_ ( .D(n2225), .CLK(
        HCLK), .RSTB(n4902), .Q(AHB_SPI_WRAPPER_sl_wdata[29]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_18_ ( .D(n2472), .CLK(HCLK), 
        .RSTB(n4899), .Q(AHB_I2C_WRAPPER_tx_data[18]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_27_ ( .D(n2463), .CLK(HCLK), 
        .RSTB(n4891), .Q(AHB_I2C_WRAPPER_tx_data[27]) );
  NAND4X1_HVT U3340 ( .A1(n3044), .A2(n3043), .A3(n3042), .A4(n3041), .Y(n5461) );
  NAND4X1_HVT U3465 ( .A1(n3161), .A2(n3160), .A3(n3159), .A4(n5158), .Y(n5374) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_12_ ( .D(n2478), .CLK(HCLK), 
        .RSTB(n4889), .Q(AHB_I2C_WRAPPER_tx_data[12]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_4_ ( .D(n2594), .CLK(HCLK), 
        .RSTB(n4897), .Q(AHB_SPI_WRAPPER_sl_rdata[4]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_27_ ( .D(n2227), .CLK(
        HCLK), .RSTB(n4902), .Q(AHB_SPI_WRAPPER_sl_wdata[27]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_17_ ( .D(n2473), .CLK(HCLK), 
        .RSTB(n4899), .Q(AHB_I2C_WRAPPER_tx_data[17]) );
  NAND2X4_HVT U4554 ( .A1(n5458), .A2(n5293), .Y(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[7]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_18_ ( .D(n2507), .CLK(HCLK), 
        .RSTB(n4905), .Q(AHB_I2C_WRAPPER_sl_rdata[18]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_1_ ( .D(n2489), .CLK(HCLK), 
        .RSTB(n4912), .Q(AHB_I2C_WRAPPER_tx_data[1]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_1_ ( .D(n2597), .CLK(HCLK), 
        .RSTB(n4893), .Q(AHB_SPI_WRAPPER_sl_rdata[1]), .QN(n4624) );
  DFFARX2_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_6_ ( .D(n2063), .CLK(
        HCLK), .RSTB(n4886), .Q(AHB_I2C_WRAPPER_sl_wdata[6]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_19_ ( .D(n2506), .CLK(HCLK), 
        .RSTB(n4905), .Q(AHB_I2C_WRAPPER_sl_rdata[19]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_4_ ( .D(n2486), .CLK(HCLK), 
        .RSTB(n4889), .Q(AHB_I2C_WRAPPER_tx_data[4]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_3_ ( .D(n2487), .CLK(HCLK), 
        .RSTB(n4912), .Q(AHB_I2C_WRAPPER_tx_data[3]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_24_ ( .D(n2501), .CLK(HCLK), 
        .RSTB(n4912), .Q(AHB_I2C_WRAPPER_sl_rdata[24]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_25_ ( .D(n2500), .CLK(HCLK), 
        .RSTB(n4912), .Q(AHB_I2C_WRAPPER_sl_rdata[25]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_17_ ( .D(n2508), .CLK(HCLK), 
        .RSTB(n4913), .Q(AHB_I2C_WRAPPER_sl_rdata[17]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_3_ ( .D(n2066), .CLK(
        HCLK), .RSTB(n4886), .Q(AHB_I2C_WRAPPER_sl_wdata[3]) );
  NAND3X2_HVT U5170 ( .A1(n5531), .A2(n4707), .A3(n5487), .Y(n4256) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_23_ ( .D(n2543), .CLK(HCLK), 
        .RSTB(n4908), .Q(AHB_SPI_WRAPPER_tx_data[23]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_21_ ( .D(n2504), .CLK(HCLK), 
        .RSTB(n4913), .Q(AHB_I2C_WRAPPER_sl_rdata[21]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_size_reg_2_ ( .D(n1937), .CLK(
        HCLK), .RSTB(n4901), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_size[2]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_2_ ( .D(n2109), .CLK(
        HCLK), .RSTB(n4911), .QN(n4681) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_22_ ( .D(n2503), .CLK(HCLK), 
        .RSTB(n4912), .Q(AHB_I2C_WRAPPER_sl_rdata[22]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_slave_select_reg_0_ ( .D(n2534), .CLK(
        HCLK), .RSTB(n4884), .Q(AHB_SPI_WRAPPER_slave_select[0]) );
  INVX4_HVT U4419 ( .A(AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_STATE[0]), 
        .Y(n5012) );
  DFFARX2_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_20_ ( .D(n2049), .CLK(
        HCLK), .RSTB(n4909), .Q(AHB_I2C_WRAPPER_sl_wdata[20]) );
  NAND2X4_HVT U4033 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_counter[0]), .A2(
        n4410), .Y(n3573) );
  DFFARX2_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_27_ ( .D(n2042), .CLK(
        HCLK), .RSTB(n4904), .Q(AHB_I2C_WRAPPER_sl_wdata[27]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_19_ ( .D(n2050), .CLK(
        HCLK), .RSTB(n4909), .Q(AHB_I2C_WRAPPER_sl_wdata[19]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_21_ ( .D(n2048), .CLK(
        HCLK), .RSTB(n4909), .Q(AHB_I2C_WRAPPER_sl_wdata[21]) );
  OR4X4_HVT U3598 ( .A1(n3291), .A2(n3290), .A3(n3289), .A4(n3288), .Y(n3292)
         );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_spi_start_reg ( .D(
        AHB_SPI_WRAPPER_SPI_REG_N105), .CLK(HCLK), .RSTB(n4884), .Q(
        AHB_SPI_WRAPPER_spi_start) );
  NAND2X4_HVT U3821 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_SUBSTATE), .A2(n4361), 
        .Y(n4370) );
  DFFARX2_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_2_ ( .D(n2067), .CLK(
        HCLK), .RSTB(n4886), .Q(AHB_I2C_WRAPPER_sl_wdata[2]) );
  NAND2X4_HVT U3278 ( .A1(n5468), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram2_rdata[11]), .Y(n2982) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_addr_reg_11_ ( .D(n2350), .CLK(
        HCLK), .RSTB(n4896), .Q(AHB_SRAM_WRAPPER_sl_addr[11]), .QN(n4610) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_1_ ( .D(n2405), .CLK(
        HCLK), .RSTB(n4904), .Q(AHB_SRAM_WRAPPER_sl_wdata[1]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte_reg_4_ ( .D(n1921), .CLK(
        HCLK), .RSTB(n4903), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[4]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_27_ ( .D(n2539), .CLK(HCLK), 
        .RSTB(n4882), .Q(AHB_SPI_WRAPPER_tx_data[27]) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_addr_reg_reg_0_ ( .D(n2346), .CLK(
        HCLK), .RSTB(n4894), .Q(AHB_UART_WRAPPER_AHB_UART_SUB_addr_reg[0]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter_reg_0_ ( 
        .D(n1852), .CLK(HCLK), .RSTB(n4879), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Sample_Counter[0]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter_reg_0_ ( 
        .D(n4915), .CLK(HCLK), .RSTB(n4896), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_baudrate_gen_tx_counter[0]) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_4_ ( .D(n2402), .CLK(
        HCLK), .RSTB(n4913), .Q(AHB_SRAM_WRAPPER_sl_wdata[4]) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_addr_reg_9_ ( .D(n2352), .CLK(
        HCLK), .RSTB(n4896), .Q(AHB_SRAM_WRAPPER_sl_addr[9]), .QN(n4612) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_8_ ( .D(n2517), .CLK(HCLK), 
        .RSTB(n4913), .Q(AHB_I2C_WRAPPER_sl_rdata[8]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte_reg_1_ ( .D(n1887), .CLK(
        HCLK), .RSTB(n4913), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[1]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_30_ ( .D(n2460), .CLK(HCLK), 
        .RSTB(n4889), .Q(AHB_I2C_WRAPPER_tx_data[30]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_tx_data_reg_21_ ( .D(n2545), .CLK(HCLK), 
        .RSTB(n4882), .Q(AHB_SPI_WRAPPER_tx_data[21]) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_addr_reg_reg_1_ ( .D(n2345), .CLK(
        HCLK), .RSTB(n4905), .Q(AHB_UART_WRAPPER_AHB_UART_SUB_addr_reg[1]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte_reg_0_ ( .D(n1882), .CLK(
        HCLK), .RSTB(n4889), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_rx_byte[0]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_1_ ( .D(n2524), .CLK(HCLK), 
        .RSTB(n4912), .Q(AHB_I2C_WRAPPER_sl_rdata[1]) );
  NAND2X4_HVT U3512 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[22]), .Y(n3212) );
  NAND2X4_HVT U3392 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[0]), .Y(n3092) );
  NAND2X4_HVT U3470 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[2]), .Y(n3168) );
  NAND2X4_HVT U3463 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[13]), .Y(n3159) );
  NAND2X4_HVT U3265 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[25]), .Y(n2970) );
  NAND2X4_HVT U3298 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[8]), .Y(n3005) );
  NAND2X4_HVT U3525 ( .A1(n5250), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[22]), .Y(n3217) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_27_ ( .D(n2498), .CLK(HCLK), 
        .RSTB(n4908), .Q(AHB_I2C_WRAPPER_sl_rdata[27]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_10_ ( .D(n2588), .CLK(HCLK), 
        .RSTB(n4907), .Q(AHB_SPI_WRAPPER_sl_rdata[10]) );
  NAND2X4_HVT U3476 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[2]), .Y(n3171) );
  NAND2X4_HVT U3584 ( .A1(n2809), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram9_rdata[18]), .Y(n3278) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_12_ ( .D(n2586), .CLK(HCLK), 
        .RSTB(n4908), .Q(AHB_SPI_WRAPPER_sl_rdata[12]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_11_ ( .D(n2587), .CLK(HCLK), 
        .RSTB(n4908), .Q(AHB_SPI_WRAPPER_sl_rdata[11]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_19_ ( .D(n2579), .CLK(HCLK), 
        .RSTB(n4907), .Q(AHB_SPI_WRAPPER_sl_rdata[19]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_14_ ( .D(n2584), .CLK(HCLK), 
        .RSTB(n4907), .Q(AHB_SPI_WRAPPER_sl_rdata[14]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_9_ ( .D(n2589), .CLK(HCLK), 
        .RSTB(n4897), .Q(AHB_SPI_WRAPPER_sl_rdata[9]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_18_ ( .D(n2580), .CLK(HCLK), 
        .RSTB(n4907), .Q(AHB_SPI_WRAPPER_sl_rdata[18]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_13_ ( .D(n2585), .CLK(HCLK), 
        .RSTB(n4882), .Q(AHB_SPI_WRAPPER_sl_rdata[13]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_15_ ( .D(n2583), .CLK(HCLK), 
        .RSTB(n4908), .Q(AHB_SPI_WRAPPER_sl_rdata[15]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_20_ ( .D(n2578), .CLK(HCLK), 
        .RSTB(n4908), .Q(AHB_SPI_WRAPPER_sl_rdata[20]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_17_ ( .D(n2581), .CLK(HCLK), 
        .RSTB(n4907), .Q(AHB_SPI_WRAPPER_sl_rdata[17]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_16_ ( .D(n2582), .CLK(HCLK), 
        .RSTB(n4908), .Q(AHB_SPI_WRAPPER_sl_rdata[16]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_22_ ( .D(n2576), .CLK(HCLK), 
        .RSTB(n4907), .Q(AHB_SPI_WRAPPER_sl_rdata[22]) );
  NAND4X1_HVT U3138 ( .A1(n2859), .A2(n2858), .A3(n2857), .A4(n2856), .Y(n5372) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_21_ ( .D(n2577), .CLK(HCLK), 
        .RSTB(n4908), .Q(AHB_SPI_WRAPPER_sl_rdata[21]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_3_ ( .D(n2104), .CLK(
        HCLK), .RSTB(n4894), .QN(n4685) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_16_ ( .D(n2326), 
        .CLK(HCLK), .RSTB(n4909), .Q(AHB_UART_WRAPPER_sl_wdata[16]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_25_ ( .D(n2611), .CLK(HCLK), .RSTB(n4887), .Q(AHB_UART_WRAPPER_tx_data[25]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_31_ ( .D(n2459), .CLK(HCLK), 
        .RSTB(n4889), .Q(AHB_I2C_WRAPPER_tx_data[31]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_26_ ( .D(n2572), .CLK(HCLK), 
        .RSTB(n4897), .Q(AHB_SPI_WRAPPER_sl_rdata[26]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_25_ ( .D(n2573), .CLK(HCLK), 
        .RSTB(n4897), .Q(AHB_SPI_WRAPPER_sl_rdata[25]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_addr_reg_reg_1_ ( .D(n2072), .CLK(
        HCLK), .RSTB(n4905), .Q(AHB_I2C_WRAPPER_AHB_I2C_SUB_addr_reg[1]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_addr_reg_reg_3_ ( .D(n2070), .CLK(
        HCLK), .RSTB(n4905), .Q(AHB_I2C_WRAPPER_AHB_I2C_SUB_addr_reg[3]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_2_ ( .D(n2634), .CLK(HCLK), 
        .RSTB(n4903), .Q(AHB_UART_WRAPPER_tx_data[2]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_27_ ( .D(n2571), .CLK(HCLK), 
        .RSTB(n4897), .Q(AHB_SPI_WRAPPER_sl_rdata[27]) );
  NAND2X2_HVT U5168 ( .A1(n5136), .A2(n4247), .Y(n4271) );
  NBUFFX8_HVT U4720 ( .A(n3326), .Y(n5138) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE_reg_3_ ( .D(n1932), .CLK(
        HCLK), .RSTB(n4901), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[3]), .QN(
        n4719) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_20_ ( .D(n2616), .CLK(HCLK), .RSTB(n4899), .Q(AHB_UART_WRAPPER_tx_data[20]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte_reg_1_ ( .D(n2118), .CLK(
        HCLK), .RSTB(n4894), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte[1]), 
        .QN(n4676) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_24_ ( .D(n2574), .CLK(HCLK), 
        .RSTB(n4882), .Q(AHB_SPI_WRAPPER_sl_rdata[24]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_4_ ( .D(n2632), .CLK(HCLK), 
        .RSTB(n4903), .Q(AHB_UART_WRAPPER_tx_data[4]) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_0_ ( .D(n2406), .CLK(
        HCLK), .RSTB(n4889), .Q(AHB_SRAM_WRAPPER_sl_wdata[0]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_1_ ( .D(n2114), .CLK(
        HCLK), .RSTB(n4894), .QN(n4675) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_5_ ( .D(n2094), .CLK(
        HCLK), .RSTB(n4894), .QN(n4695) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte_reg_4_ ( .D(n2103), .CLK(
        HCLK), .RSTB(n4894), .Q(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_byte[4]), 
        .QN(n4691) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_tx_data_reg_3_ ( .D(n2633), .CLK(HCLK), 
        .RSTB(n4887), .Q(AHB_UART_WRAPPER_tx_data[3]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_26_ ( .D(n2464), .CLK(HCLK), 
        .RSTB(n4912), .Q(AHB_I2C_WRAPPER_tx_data[26]) );
  NAND2X2_HVT U3447 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[13]), .Y(n3148) );
  DFFARX2_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_wstrb_reg_reg_3_ ( .D(n2216), .CLK(
        HCLK), .RSTB(n4898), .Q(AHB_SPI_WRAPPER_AHB_SPI_SUB_wstrb_reg[3]) );
  DFFARX2_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_17_ ( .D(n2389), 
        .CLK(HCLK), .RSTB(n4909), .Q(AHB_SRAM_WRAPPER_sl_wdata[17]) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_REG_sl_rdata_reg_23_ ( .D(n2575), .CLK(HCLK), 
        .RSTB(n4882), .Q(AHB_SPI_WRAPPER_sl_rdata[23]) );
  NAND2X4_HVT U3177 ( .A1(n5517), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram15_rdata[7]), .Y(n2886) );
  NAND2X4_HVT U3574 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[16]), .Y(n3263) );
  NAND2X4_HVT U3166 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[7]), .Y(n2879) );
  NAND2X4_HVT U3517 ( .A1(n5518), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram12_rdata[22]), .Y(n3216) );
  NAND2X4_HVT U3541 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[21]), .Y(n3235) );
  NAND2X4_HVT U3254 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[25]), .Y(n2963) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_20_ ( .D(n2505), .CLK(HCLK), 
        .RSTB(n4905), .Q(AHB_I2C_WRAPPER_sl_rdata[20]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_1_ ( .D(n2068), .CLK(
        HCLK), .RSTB(n4904), .Q(AHB_I2C_WRAPPER_sl_wdata[1]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_rx_byte_size_reg_2_ ( .D(n2491), .CLK(
        HCLK), .RSTB(n4912), .Q(AHB_I2C_WRAPPER_rx_byte_size[2]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_REG_sl_rdata_reg_9_ ( .D(n2516), .CLK(HCLK), 
        .RSTB(n4913), .Q(AHB_I2C_WRAPPER_sl_rdata[9]) );
  NAND2X4_HVT U3390 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[0]), .Y(n3094) );
  INVX4_HVT U3809 ( .A(AHB_I2C_WRAPPER_tx_data[31]), .Y(n4916) );
  NAND2X4_HVT U3210 ( .A1(n2789), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram8_rdata[1]), .Y(n2921) );
  DFFARX2_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_25_ ( .D(n2044), .CLK(
        HCLK), .RSTB(n4904), .Q(AHB_I2C_WRAPPER_sl_wdata[25]) );
  INVX4_HVT U3829 ( .A(AHB_I2C_WRAPPER_tx_data[27]), .Y(n4918) );
  MUX21X2_HVT U4092 ( .A1(n3558), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[5]), .S0(n5198), .Y(n1920) );
  MUX41X2_HVT U5549 ( .A1(sram_rdata[26]), .A3(spi_rdata[26]), .A2(
        uart_rdata[26]), .A4(i2c_rdata[26]), .S0(n5092), .S1(n5094), .Y(
        HRDATA[26]) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte_reg_0_ ( .D(n1925), .CLK(
        HCLK), .RSTB(n4899), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[0]) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_18_ ( .D(n2324), 
        .CLK(HCLK), .RSTB(n4891), .Q(AHB_UART_WRAPPER_sl_wdata[18]) );
  DFFARX2_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_13_ ( .D(n2329), 
        .CLK(HCLK), .RSTB(n4891), .Q(AHB_UART_WRAPPER_sl_wdata[13]) );
  NAND4X1_HVT U3587 ( .A1(n3279), .A2(n3278), .A3(n3277), .A4(n3276), .Y(n5312) );
  DFFARX2_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte_reg_5_ ( .D(n1920), .CLK(
        HCLK), .RSTB(n4901), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_byte[5]) );
  DFFARX2_HVT AHB_UART_WRAPPER_UART_REG_tx_start_reg ( .D(
        AHB_UART_WRAPPER_UART_REG_N109), .CLK(HCLK), .RSTB(n4903), .Q(
        AHB_UART_WRAPPER_tx_start) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_7_ ( .D(n2084), .CLK(
        HCLK), .RSTB(n4907), .QN(n4705) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_6_ ( .D(n2089), .CLK(
        HCLK), .RSTB(n4894), .QN(n4700) );
  DFFARX2_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_data_reg_0_ ( .D(n2119), .CLK(
        HCLK), .RSTB(n4907), .QN(n4671) );
  NAND2X4_HVT U3691 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[14]), .Y(n3378) );
  NAND2X4_HVT U3420 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[24]), .Y(n3116) );
  NAND2X4_HVT U5065 ( .A1(n5415), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[30]), .Y(n4146) );
  NAND2X4_HVT U3035 ( .A1(n5490), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram0_rdata[12]), .Y(n2804) );
  OAI222X2_HVT U4947 ( .A1(n4923), .A2(n5533), .A3(n4948), .A4(n5106), .A5(
        n4646), .A6(n5491), .Y(n2505) );
  OAI222X2_HVT U4944 ( .A1(n4924), .A2(n5533), .A3(n4949), .A4(n5106), .A5(
        n4645), .A6(n5491), .Y(n2506) );
  NAND2X2_HVT U5038 ( .A1(n2806), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram11_rdata[29]), .Y(n4122) );
  NAND2X2_HVT U3566 ( .A1(n2799), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram14_rdata[16]), .Y(n3262) );
  NAND2X2_HVT U3341 ( .A1(n2816), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram10_rdata[20]), .Y(n3048) );
  NAND2X2_HVT U4557 ( .A1(n5427), .A2(n5293), .Y(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[10]) );
  NAND2X2_HVT U4552 ( .A1(n2800), .A2(n5293), .Y(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[5]) );
  NAND2X2_HVT U4558 ( .A1(n5426), .A2(n5293), .Y(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_cs_n[11]) );
  INVX4_HVT U4648 ( .A(n5520), .Y(n5110) );
  AND3X1_HVT U3079 ( .A1(AHB_SRAM_WRAPPER_sl_addr[10]), .A2(
        AHB_SRAM_WRAPPER_sl_addr[9]), .A3(n2817), .Y(n5294) );
  AND4X1_HVT U3044 ( .A1(AHB_SRAM_WRAPPER_sl_addr[8]), .A2(
        AHB_SRAM_WRAPPER_sl_addr[10]), .A3(n4610), .A4(n4612), .Y(n5280) );
  INVX4_HVT U4536 ( .A(n4743), .Y(n5092) );
  DFFASX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_CS_n_reg_0_ ( .D(n1812), .CLK(
        HCLK), .SETB(n4911), .Q(n5319) );
  DFFASX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_CS_n_reg_3_ ( .D(n1809), .CLK(
        HCLK), .SETB(n4911), .Q(n5332) );
  DFFASX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_CS_n_reg_1_ ( .D(n1811), .CLK(
        HCLK), .SETB(n4911), .Q(n5314) );
  DFFASX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Tx_reg ( .D(n1807), 
        .CLK(HCLK), .SETB(n4911), .Q(n5304) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Bit_Counter_reg_0_ ( 
        .D(n1873), .CLK(HCLK), .RSTB(n4884), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Bit_Counter[0]) );
  DFFASX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_CS_n_reg_2_ ( .D(n1810), .CLK(
        HCLK), .SETB(n4911), .Q(n5295) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Bit_Counter_reg_1_ ( 
        .D(n1872), .CLK(HCLK), .RSTB(n4884), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Bit_Counter[1]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Bit_Counter_reg_2_ ( 
        .D(n1871), .CLK(HCLK), .RSTB(n4884), .Q(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Bit_Counter[2]), .QN(
        n5302) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_1_ ( .D(n1987), 
        .CLK(HCLK), .RSTB(n4908), .Q(n5492) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_3_ ( .D(n1985), 
        .CLK(HCLK), .RSTB(n4908), .Q(n5493) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE_reg_0_ ( .D(n1935), .CLK(
        HCLK), .RSTB(n4901), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[0]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_2_ ( .D(n1986), 
        .CLK(HCLK), .RSTB(n4908), .Q(n5436) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_4_ ( .D(n1984), 
        .CLK(HCLK), .RSTB(n4898), .Q(n5425) );
  DFFARX1_HVT AHB_DECMUX_mux_select_reg_1_ ( .D(n2454), .CLK(HCLK), .RSTB(
        n4885), .QN(n4743) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_21_ ( .D(n2385), 
        .CLK(HCLK), .RSTB(n4904), .Q(n5422) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_23_ ( .D(n2383), 
        .CLK(HCLK), .RSTB(n4904), .Q(n5412) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_5_ ( .D(n1983), 
        .CLK(HCLK), .RSTB(n4908), .Q(n5417) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_SUBSTATE_reg ( .D(n1936), .CLK(
        HCLK), .RSTB(n4903), .Q(AHB_I2C_WRAPPER_I2C_CONTROLLER_SUBSTATE) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_20_ ( .D(n2386), 
        .CLK(HCLK), .RSTB(n4904), .Q(n5410) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_12_ ( .D(n1976), 
        .CLK(HCLK), .RSTB(n4898), .Q(n5364) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_22_ ( .D(n2384), 
        .CLK(HCLK), .RSTB(n4904), .Q(n5361) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg_reg_9_ ( .D(n2409), .CLK(
        HCLK), .RSTB(n4904), .Q(n5360) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_11_ ( .D(n1977), 
        .CLK(HCLK), .RSTB(n4905), .Q(n5358) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_1_ ( .D(n2341), .CLK(
        HCLK), .RSTB(n4886), .Q(AHB_UART_WRAPPER_sl_wdata[1]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_0_ ( .D(n1988), 
        .CLK(HCLK), .RSTB(n4905), .Q(n5357) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_13_ ( .D(n1975), 
        .CLK(HCLK), .RSTB(n4898), .Q(n5349) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg_reg_10_ ( .D(n2408), 
        .CLK(HCLK), .RSTB(n4910), .Q(n5343) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_2_ ( .D(n2340), .CLK(
        HCLK), .RSTB(n4886), .Q(AHB_UART_WRAPPER_sl_wdata[2]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_24_ ( .D(n2382), 
        .CLK(HCLK), .RSTB(n4904), .Q(n5336) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_19_ ( .D(n2235), .CLK(
        HCLK), .RSTB(n4904), .Q(n5318) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg_reg_11_ ( .D(n2407), 
        .CLK(HCLK), .RSTB(n4910), .Q(n5330) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_SCK_reg ( .D(n2077), .CLK(HCLK), 
        .RSTB(n4911), .Q(n5317) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_28_ ( .D(n2314), 
        .CLK(HCLK), .RSTB(n4888), .Q(n5316) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_addr_reg_reg_2_ ( .D(n2256), .CLK(
        HCLK), .RSTB(n4902), .Q(n5315) );
  DFFARX1_HVT AHB_SPI_WRAPPER_SPI_CONTROLLER_MOSI_reg ( .D(n2078), .CLK(HCLK), 
        .RSTB(n4911), .Q(n5296) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_25_ ( .D(n2381), 
        .CLK(HCLK), .RSTB(n4904), .Q(n5292) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_wdata_reg_7_ ( .D(n2399), .CLK(
        HCLK), .RSTB(n4891), .Q(n5279) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift_reg_6_ ( .D(n1982), 
        .CLK(HCLK), .RSTB(n4888), .Q(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[6]) );
  DFFARX1_HVT AHB_UART_WRAPPER_AHB_UART_SUB_sl_wdata_reg_4_ ( .D(n2338), .CLK(
        HCLK), .RSTB(n4913), .Q(AHB_UART_WRAPPER_sl_wdata[4]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_5_ ( .D(n2249), .CLK(
        HCLK), .RSTB(n4886), .Q(AHB_SPI_WRAPPER_sl_wdata[5]) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_0_ ( .D(n2668), .CLK(HCLK), .RSTB(n4887), .Q(n5387), .QN(n4614) );
  DFFARX1_HVT AHB_UART_WRAPPER_UART_REG_sl_rdata_reg_1_ ( .D(n2667), .CLK(HCLK), .RSTB(n4887), .Q(n5359), .QN(n4615) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_4_ ( .D(n2065), .CLK(
        HCLK), .RSTB(n4889), .Q(AHB_I2C_WRAPPER_sl_wdata[4]) );
  DFFARX1_HVT AHB_I2C_WRAPPER_AHB_I2C_SUB_sl_wdata_reg_5_ ( .D(n2064), .CLK(
        HCLK), .RSTB(n4886), .Q(AHB_I2C_WRAPPER_sl_wdata[5]) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_21_ ( .D(n2233), .CLK(
        HCLK), .RSTB(n4904), .Q(n5329) );
  DFFARX1_HVT AHB_SPI_WRAPPER_AHB_SPI_SUB_sl_wdata_reg_23_ ( .D(n2231), .CLK(
        HCLK), .RSTB(n4904), .Q(n5286) );
  DFFARX1_HVT AHB_I2C_WRAPPER_I2C_REG_tx_data_reg_11_ ( .D(n2479), .CLK(HCLK), 
        .RSTB(n4913), .Q(AHB_I2C_WRAPPER_tx_data[11]) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_addr_reg_1_ ( .D(n2360), .CLK(
        HCLK), .RSTB(n4896), .Q(n5277) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_addr_reg_2_ ( .D(n2359), .CLK(
        HCLK), .RSTB(n4896), .Q(n5282) );
  DFFARX1_HVT AHB_SRAM_WRAPPER_AHB_SRAM_SUB_sl_addr_reg_0_ ( .D(n2361), .CLK(
        HCLK), .RSTB(n4896), .Q(n5276) );
  NAND4X0_HVT U5541 ( .A1(n4595), .A2(n4594), .A3(n4593), .A4(n4592), .Y(n5326) );
  OAI22X1_HVT U5271 ( .A1(n5454), .A2(n5155), .A3(n5168), .A4(n4326), .Y(n5496) );
  OR4X2_HVT U3224 ( .A1(n2934), .A2(n2933), .A3(n2932), .A4(n2931), .Y(n2935)
         );
  AND2X2_HVT U4546 ( .A1(AHB_SRAM_WRAPPER_valid_trans), .A2(n4894), .Y(n3728)
         );
  NAND3X0_HVT U2816 ( .A1(n2715), .A2(n3949), .A3(n4660), .Y(n5308) );
  NAND4X0_HVT U3213 ( .A1(n2922), .A2(n2921), .A3(n2920), .A4(n2919), .Y(n5489) );
  NAND4X0_HVT U3553 ( .A1(n3245), .A2(n3244), .A3(n3243), .A4(n3242), .Y(n5421) );
  NAND4X0_HVT U3670 ( .A1(n3360), .A2(n3359), .A3(n3358), .A4(n3357), .Y(n5455) );
  NAND4X0_HVT U5015 ( .A1(n4094), .A2(n4093), .A3(n4092), .A4(n4091), .Y(n5484) );
  NAND4X0_HVT U3230 ( .A1(n2939), .A2(n2938), .A3(n2937), .A4(n2936), .Y(n5450) );
  NAND4X0_HVT U3174 ( .A1(n5146), .A2(n2883), .A3(n5159), .A4(n2881), .Y(n5440) );
  NAND4X0_HVT U3543 ( .A1(n3237), .A2(n3236), .A3(n3235), .A4(n3234), .Y(n5327) );
  NAND4X0_HVT U3680 ( .A1(n3368), .A2(n3367), .A3(n3366), .A4(n3365), .Y(n5377) );
  NAND4X0_HVT U3707 ( .A1(n3393), .A2(n3392), .A3(n3391), .A4(n3390), .Y(n5375) );
  NAND4X0_HVT U3257 ( .A1(n2964), .A2(n2963), .A3(n2962), .A4(n2961), .Y(n5328) );
  NAND4X0_HVT U3377 ( .A1(n3077), .A2(n3076), .A3(n3075), .A4(n3074), .Y(n5373) );
  NAND4X0_HVT U3289 ( .A1(n2993), .A2(n2992), .A3(n2991), .A4(n2990), .Y(n5301) );
  NAND4X0_HVT U3626 ( .A1(n3317), .A2(n3316), .A3(n3315), .A4(n3314), .Y(n5310) );
  NAND4X0_HVT U3658 ( .A1(n3347), .A2(n3346), .A3(n3345), .A4(n3344), .Y(n5289) );
  NAND2X2_HVT U5049 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[29]), .Y(n4129) );
  NAND2X2_HVT U3022 ( .A1(n5458), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[12]), .Y(n2795) );
  NAND2X2_HVT U3480 ( .A1(n5458), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[2]), .Y(n3176) );
  NAND2X2_HVT U3131 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[15]), .Y(n2859) );
  NAND2X2_HVT U3583 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[18]), .Y(n3279) );
  NAND2X2_HVT U3551 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[21]), .Y(n3243) );
  NAND2X0_HVT U3207 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[1]), .Y(n5442) );
  NAND2X2_HVT U3227 ( .A1(n5458), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[5]), .Y(n2938) );
  NAND2X2_HVT U3337 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[20]), .Y(n3043) );
  NAND2X2_HVT U3276 ( .A1(n5458), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[11]), .Y(n2984) );
  NAND2X0_HVT U3193 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[19]), .Y(n5303) );
  NAND2X0_HVT U3190 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[19]), .Y(n5346) );
  NAND2X0_HVT U3434 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[17]), .Y(n5362) );
  NAND2X0_HVT U3283 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[11]), .Y(n5344) );
  OA21X1_HVT U5526 ( .A1(n4573), .A2(n4572), .A3(n5370), .Y(n5494) );
  OA21X1_HVT U5537 ( .A1(n4587), .A2(n4586), .A3(n4742), .Y(n5495) );
  NAND2X2_HVT U3439 ( .A1(n5534), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram6_rdata[17]), .Y(n3140) );
  NAND2X0_HVT U3656 ( .A1(n5274), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[26]), .Y(n5313) );
  NAND2X2_HVT U3514 ( .A1(n2790), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[22]), .Y(n3210) );
  NAND2X0_HVT U3549 ( .A1(n5523), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[21]), .Y(n5288) );
  NAND2X0_HVT U3625 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[6]), .Y(n5298) );
  NAND2X0_HVT U3237 ( .A1(n2805), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram4_rdata[5]), .Y(n5299) );
  NAND2X0_HVT U3316 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[4]), .Y(n5331) );
  NAND3X0_HVT U3721 ( .A1(n3408), .A2(n5111), .A3(AHB_UART_WRAPPER_tx_start), 
        .Y(n5485) );
  NOR3X0_HVT U3743 ( .A1(AHB_UART_WRAPPER_sl_addr[0]), .A2(
        AHB_UART_WRAPPER_sl_addr[1]), .A3(n3763), .Y(n5369) );
  NAND2X0_HVT U3047 ( .A1(n2800), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram5_rdata[12]), .Y(n5321) );
  NAND2X0_HVT U3442 ( .A1(n5523), .A2(
        AHB_SRAM_WRAPPER_SRAM_CONTROLLER_sram7_rdata[17]), .Y(n5297) );
  AND3X1_HVT U3058 ( .A1(AHB_SRAM_WRAPPER_sl_addr[8]), .A2(n2808), .A3(n4610), 
        .Y(n2807) );
  AND3X1_HVT U3071 ( .A1(AHB_SRAM_WRAPPER_sl_addr[9]), .A2(n2817), .A3(n4611), 
        .Y(n2815) );
  AND3X1_HVT U3062 ( .A1(AHB_SRAM_WRAPPER_sl_addr[11]), .A2(
        AHB_SRAM_WRAPPER_sl_addr[8]), .A3(n2808), .Y(n2809) );
  AND3X1_HVT U3050 ( .A1(AHB_SRAM_WRAPPER_sl_addr[10]), .A2(n2817), .A3(n4612), 
        .Y(n5300) );
  AND4X1_HVT U3019 ( .A1(AHB_SRAM_WRAPPER_sl_addr[8]), .A2(
        AHB_SRAM_WRAPPER_sl_addr[10]), .A3(AHB_SRAM_WRAPPER_sl_addr[9]), .A4(
        n4610), .Y(n2790) );
  OA22X1_HVT U3844 ( .A1(uart_readyout), .A2(n3449), .A3(i2c_readyout), .A4(
        n3448), .Y(n4062) );
  NAND3X0_HVT U3807 ( .A1(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[2]), .A2(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[1]), .A3(n5108), .Y(n4398) );
  OAI221X1_HVT U2640 ( .A1(AHB_UART_WRAPPER_rx_byte_size[1]), .A2(n2788), .A3(
        n2761), .A4(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Counter[1]), .A5(
        n2760), .Y(n5200) );
  NOR3X2_HVT U2641 ( .A1(AHB_UART_WRAPPER_rx_byte_size[1]), .A2(
        AHB_UART_WRAPPER_rx_byte_size[2]), .A3(
        AHB_UART_WRAPPER_rx_byte_size[0]), .Y(n5201) );
  OAI221X1_HVT U2658 ( .A1(AHB_UART_WRAPPER_tx_byte_size[1]), .A2(n5013), .A3(
        n3757), .A4(n5507), .A5(n3765), .Y(n5202) );
  INVX1_HVT U2975 ( .A(SPI_MISO), .Y(n5522) );
  NBUFFX2_HVT U2976 ( .A(n3739), .Y(n5504) );
  NBUFFX2_HVT U2981 ( .A(n3763), .Y(n5520) );
  NBUFFX2_HVT U3029 ( .A(AHB_I2C_WRAPPER_sl_rdata[3]), .Y(n5345) );
  NBUFFX2_HVT U3080 ( .A(n3988), .Y(n5508) );
  NBUFFX2_HVT U3141 ( .A(n4677), .Y(n5487) );
  NBUFFX4_HVT U3729 ( .A(n4593), .Y(n5367) );
  NBUFFX2_HVT U3730 ( .A(n4522), .Y(n5501) );
  NBUFFX2_HVT U4448 ( .A(AHB_SPI_WRAPPER_sl_rdata[19]), .Y(n5334) );
  NBUFFX2_HVT U4450 ( .A(AHB_UART_WRAPPER_sl_wdata[29]), .Y(n5333) );
  NBUFFX2_HVT U4452 ( .A(AHB_SPI_WRAPPER_sl_rdata[7]), .Y(n5339) );
  NBUFFX2_HVT U4461 ( .A(AHB_UART_WRAPPER_sl_wdata[31]), .Y(n5338) );
  NBUFFX2_HVT U4462 ( .A(AHB_UART_WRAPPER_sl_wdata[30]), .Y(n5352) );
  NBUFFX2_HVT U4463 ( .A(AHB_SPI_WRAPPER_sl_rdata[10]), .Y(n5355) );
  NBUFFX2_HVT U4464 ( .A(AHB_UART_WRAPPER_sl_wdata[3]), .Y(n5354) );
  NBUFFX2_HVT U4465 ( .A(AHB_UART_WRAPPER_sl_wdata[0]), .Y(n5356) );
  NBUFFX2_HVT U4466 ( .A(AHB_UART_WRAPPER_AHB_UART_SUB_addr_reg[2]), .Y(n5380)
         );
  NBUFFX2_HVT U4489 ( .A(AHB_SPI_WRAPPER_AHB_SPI_SUB_addr_reg[3]), .Y(n5385)
         );
  NBUFFX2_HVT U4628 ( .A(AHB_SPI_WRAPPER_sl_rdata[6]), .Y(n5382) );
  NBUFFX2_HVT U4945 ( .A(AHB_UART_WRAPPER_AHB_UART_SUB_addr_reg[3]), .Y(n5392)
         );
  NBUFFX2_HVT U4946 ( .A(AHB_I2C_WRAPPER_sl_rdata[29]), .Y(n5386) );
  NBUFFX2_HVT U4949 ( .A(AHB_UART_WRAPPER_sl_rdata[8]), .Y(n5396) );
  NBUFFX2_HVT U4951 ( .A(AHB_I2C_WRAPPER_tx_data[13]), .Y(n5393) );
  NBUFFX2_HVT U4952 ( .A(AHB_UART_WRAPPER_sl_rdata[7]), .Y(n5398) );
  NBUFFX2_HVT U4953 ( .A(AHB_UART_WRAPPER_sl_rdata[6]), .Y(n5405) );
  NBUFFX2_HVT U4954 ( .A(AHB_UART_WRAPPER_sl_rdata[9]), .Y(n5408) );
  NBUFFX2_HVT U4956 ( .A(AHB_SPI_WRAPPER_sl_wdata[20]), .Y(n5414) );
  NBUFFX2_HVT U4960 ( .A(AHB_UART_WRAPPER_sl_rdata[11]), .Y(n5420) );
  NBUFFX2_HVT U4962 ( .A(AHB_UART_WRAPPER_sl_rdata[10]), .Y(n5419) );
  NBUFFX2_HVT U4964 ( .A(AHB_I2C_WRAPPER_sl_rdata[28]), .Y(n5424) );
  NBUFFX2_HVT U4965 ( .A(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[7]), .Y(n5423)
         );
  NBUFFX2_HVT U4967 ( .A(AHB_UART_WRAPPER_sl_rdata[5]), .Y(n5429) );
  NBUFFX2_HVT U4969 ( .A(AHB_SPI_WRAPPER_sl_wdata[16]), .Y(n5428) );
  NBUFFX2_HVT U4971 ( .A(AHB_SPI_WRAPPER_sl_wdata[22]), .Y(n5432) );
  NBUFFX2_HVT U4973 ( .A(AHB_SPI_WRAPPER_sl_wdata[12]), .Y(n5431) );
  NBUFFX2_HVT U4975 ( .A(AHB_UART_WRAPPER_sl_rdata[12]), .Y(n5434) );
  NBUFFX2_HVT U4977 ( .A(AHB_SPI_WRAPPER_sl_wdata[14]), .Y(n5433) );
  NBUFFX2_HVT U4982 ( .A(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[8]), .Y(n5438)
         );
  NBUFFX2_HVT U4984 ( .A(AHB_SPI_WRAPPER_sl_wdata[18]), .Y(n5437) );
  NBUFFX2_HVT U4985 ( .A(AHB_UART_WRAPPER_sl_rdata[2]), .Y(n5441) );
  NBUFFX2_HVT U4994 ( .A(AHB_SPI_WRAPPER_sl_wdata[17]), .Y(n5439) );
  NBUFFX2_HVT U5022 ( .A(AHB_UART_WRAPPER_sl_rdata[3]), .Y(n5444) );
  NBUFFX2_HVT U5024 ( .A(AHB_SPI_WRAPPER_sl_wdata[11]), .Y(n5443) );
  NBUFFX2_HVT U5026 ( .A(AHB_UART_WRAPPER_sl_rdata[16]), .Y(n5446) );
  NBUFFX2_HVT U5028 ( .A(AHB_UART_WRAPPER_sl_rdata[13]), .Y(n5445) );
  NBUFFX2_HVT U5030 ( .A(AHB_UART_WRAPPER_sl_rdata[14]), .Y(n5448) );
  NBUFFX2_HVT U5033 ( .A(AHB_UART_WRAPPER_sl_rdata[4]), .Y(n5447) );
  NBUFFX2_HVT U5035 ( .A(AHB_SPI_WRAPPER_sl_wdata[9]), .Y(n5451) );
  NBUFFX2_HVT U5037 ( .A(AHB_SPI_WRAPPER_sl_wdata[13]), .Y(n5449) );
  NBUFFX2_HVT U5039 ( .A(AHB_UART_WRAPPER_sl_rdata[19]), .Y(n5453) );
  NBUFFX2_HVT U5042 ( .A(AHB_SPI_WRAPPER_sl_wdata[15]), .Y(n5452) );
  NBUFFX2_HVT U5044 ( .A(AHB_UART_WRAPPER_sl_rdata[15]), .Y(n5457) );
  NBUFFX2_HVT U5046 ( .A(AHB_UART_WRAPPER_sl_rdata[17]), .Y(n5456) );
  NBUFFX2_HVT U5048 ( .A(AHB_UART_WRAPPER_sl_rdata[21]), .Y(n5460) );
  NBUFFX2_HVT U5051 ( .A(AHB_SPI_WRAPPER_sl_wdata[10]), .Y(n5464) );
  NBUFFX2_HVT U5053 ( .A(AHB_SPI_WRAPPER_sl_wdata[1]), .Y(n5463) );
  NBUFFX2_HVT U5055 ( .A(AHB_UART_WRAPPER_sl_rdata[18]), .Y(n5466) );
  NBUFFX2_HVT U5057 ( .A(AHB_UART_WRAPPER_sl_rdata[20]), .Y(n5467) );
  NBUFFX2_HVT U5115 ( .A(AHB_UART_WRAPPER_sl_rdata[22]), .Y(n5471) );
  NBUFFX2_HVT U5122 ( .A(AHB_UART_WRAPPER_sl_rdata[24]), .Y(n5474) );
  NBUFFX2_HVT U5135 ( .A(AHB_UART_WRAPPER_sl_rdata[23]), .Y(n5476) );
  NBUFFX2_HVT U5249 ( .A(AHB_UART_WRAPPER_sl_rdata[25]), .Y(n5475) );
  NBUFFX2_HVT U5256 ( .A(n4399), .Y(n5498) );
  NBUFFX2_HVT U5269 ( .A(n4712), .Y(n5519) );
  NBUFFX2_HVT U5280 ( .A(n5084), .Y(n5273) );
  NBUFFX8_HVT U5284 ( .A(n5294), .Y(n5250) );
  NBUFFX8_HVT U5316 ( .A(n5302), .Y(n4742) );
  NBUFFX4_HVT U5328 ( .A(n5287), .Y(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_STATE[2]) );
  NBUFFX8_HVT U5330 ( .A(n5321), .Y(n2801) );
  NBUFFX8_HVT U5333 ( .A(n5297), .Y(n3137) );
  NBUFFX4_HVT U5342 ( .A(n5364), .Y(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[12]) );
  NBUFFX4_HVT U5348 ( .A(n5349), .Y(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[13]) );
  NBUFFX4_HVT U5350 ( .A(n5417), .Y(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[5]) );
  NBUFFX4_HVT U5351 ( .A(n5369), .Y(n3739) );
  NBUFFX4_HVT U5354 ( .A(n5436), .Y(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[2]) );
  NBUFFX4_HVT U5357 ( .A(n5425), .Y(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[4]) );
  NBUFFX8_HVT U5401 ( .A(n5485), .Y(n3401) );
  NBUFFX8_HVT U5435 ( .A(n5288), .Y(n3245) );
  NBUFFX8_HVT U5438 ( .A(n5299), .Y(n2946) );
  NBUFFX8_HVT U5493 ( .A(n5298), .Y(n3314) );
  NBUFFX4_HVT U5514 ( .A(n5317), .Y(SPI_SCK) );
  NBUFFX8_HVT U5519 ( .A(n5313), .Y(n3345) );
  NBUFFX4_HVT U5546 ( .A(n5358), .Y(
        AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[11]) );
  NBUFFX8_HVT U5547 ( .A(n5331), .Y(n3021) );
  NBUFFX4_HVT U5550 ( .A(n5493), .Y(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[3]) );
  NBUFFX4_HVT U5563 ( .A(n5492), .Y(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[1]) );
  NBUFFX4_HVT U5564 ( .A(n5495), .Y(n4588) );
  NBUFFX4_HVT U5565 ( .A(n5494), .Y(n4589) );
  NBUFFX8_HVT U5580 ( .A(n5276), .Y(AHB_SRAM_WRAPPER_sl_addr[0]) );
  INVX8_HVT U5581 ( .A(n5522), .Y(n5535) );
  NBUFFX4_HVT U5582 ( .A(n5304), .Y(UART_Tx) );
  NBUFFX8_HVT U5583 ( .A(n5303), .Y(n2904) );
  NBUFFX8_HVT U5584 ( .A(n5346), .Y(n2898) );
  NBUFFX8_HVT U5585 ( .A(n5344), .Y(n2986) );
  NBUFFX8_HVT U5586 ( .A(n5362), .Y(n3136) );
  NBUFFX4_HVT U5587 ( .A(n5357), .Y(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[0]) );
  NBUFFX4_HVT U5588 ( .A(n5513), .Y(n4713) );
  NBUFFX8_HVT U5589 ( .A(n5442), .Y(n2915) );
  NBUFFX4_HVT U5590 ( .A(n5515), .Y(n2719) );
  NBUFFX2_HVT U5591 ( .A(n5291), .Y(n5251) );
  NBUFFX2_HVT U5592 ( .A(n5306), .Y(n5252) );
  NBUFFX2_HVT U5593 ( .A(n5305), .Y(n5253) );
  NBUFFX2_HVT U5594 ( .A(n5320), .Y(n5254) );
  NBUFFX2_HVT U5595 ( .A(n5307), .Y(n5255) );
  NBUFFX2_HVT U5596 ( .A(n5351), .Y(n5256) );
  NBUFFX2_HVT U5597 ( .A(n5322), .Y(n5257) );
  NBUFFX2_HVT U5598 ( .A(n5366), .Y(n5258) );
  NBUFFX2_HVT U5599 ( .A(n5353), .Y(n5259) );
  NBUFFX2_HVT U5600 ( .A(n5397), .Y(n5260) );
  NBUFFX2_HVT U5601 ( .A(n5390), .Y(n5261) );
  NBUFFX2_HVT U5602 ( .A(n5416), .Y(n5262) );
  NBUFFX2_HVT U5603 ( .A(n5411), .Y(n5263) );
  NBUFFX4_HVT U5604 ( .A(n5514), .Y(n5264) );
  NBUFFX2_HVT U5605 ( .A(n5497), .Y(n5265) );
  NBUFFX4_HVT U5606 ( .A(n5516), .Y(n5266) );
  NBUFFX2_HVT U5607 ( .A(n2954), .Y(n5272) );
  NBUFFX2_HVT U5608 ( .A(n5289), .Y(n3353) );
  NBUFFX8_HVT U5609 ( .A(n5282), .Y(AHB_SRAM_WRAPPER_sl_addr[2]) );
  NBUFFX4_HVT U5610 ( .A(n5295), .Y(SPI_CS_n[2]) );
  NBUFFX2_HVT U5611 ( .A(n5301), .Y(n2994) );
  NBUFFX4_HVT U5612 ( .A(n5312), .Y(n3290) );
  NBUFFX2_HVT U5613 ( .A(n5310), .Y(n3333) );
  NBUFFX4_HVT U5614 ( .A(n5319), .Y(SPI_CS_n[0]) );
  NBUFFX4_HVT U5615 ( .A(n5314), .Y(SPI_CS_n[1]) );
  NBUFFX4_HVT U5616 ( .A(n5328), .Y(n2975) );
  NBUFFX4_HVT U5617 ( .A(n5327), .Y(n3248) );
  NBUFFX4_HVT U5618 ( .A(n5332), .Y(SPI_CS_n[3]) );
  NBUFFX2_HVT U5619 ( .A(n5368), .Y(n2953) );
  NBUFFX4_HVT U5620 ( .A(n5373), .Y(n3078) );
  NBUFFX2_HVT U5621 ( .A(n5372), .Y(n2870) );
  NBUFFX4_HVT U5622 ( .A(n5375), .Y(n3394) );
  NBUFFX4_HVT U5623 ( .A(n5374), .Y(n3162) );
  NBUFFX4_HVT U5624 ( .A(n5377), .Y(n3374) );
  NBUFFX2_HVT U5625 ( .A(n5421), .Y(n3246) );
  NBUFFX2_HVT U5626 ( .A(n5440), .Y(n2890) );
  NBUFFX4_HVT U5627 ( .A(n5484), .Y(n4104) );
  NBUFFX4_HVT U5628 ( .A(n5461), .Y(n3060) );
  NBUFFX4_HVT U5629 ( .A(n5489), .Y(n2933) );
  NBUFFX4_HVT U5630 ( .A(n5296), .Y(SPI_MOSI) );
  NBUFFX4_HVT U5631 ( .A(n5286), .Y(AHB_SPI_WRAPPER_sl_wdata[23]) );
  NBUFFX4_HVT U5632 ( .A(n5316), .Y(AHB_UART_WRAPPER_sl_wdata[28]) );
  NBUFFX4_HVT U5633 ( .A(n5315), .Y(AHB_SPI_WRAPPER_AHB_SPI_SUB_addr_reg[2])
         );
  NBUFFX4_HVT U5634 ( .A(n5318), .Y(AHB_SPI_WRAPPER_sl_wdata[19]) );
  NBUFFX4_HVT U5635 ( .A(n5330), .Y(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[11]) );
  NBUFFX4_HVT U5636 ( .A(n5329), .Y(AHB_SPI_WRAPPER_sl_wdata[21]) );
  NBUFFX4_HVT U5637 ( .A(n5359), .Y(AHB_UART_WRAPPER_sl_rdata[1]) );
  NBUFFX4_HVT U5638 ( .A(n5343), .Y(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[10]) );
  NBUFFX4_HVT U5639 ( .A(n5387), .Y(AHB_UART_WRAPPER_sl_rdata[0]) );
  NBUFFX4_HVT U5640 ( .A(n5360), .Y(AHB_SRAM_WRAPPER_AHB_SRAM_SUB_addr_reg[9])
         );
  NBUFFX8_HVT U5641 ( .A(n2686), .Y(n5529) );
  NBUFFX8_HVT U5642 ( .A(n5277), .Y(AHB_SRAM_WRAPPER_sl_addr[1]) );
  NBUFFX4_HVT U5643 ( .A(n5496), .Y(n1953) );
  NBUFFX4_HVT U5644 ( .A(n5326), .Y(n1807) );
  NBUFFX32_HVT U5645 ( .A(n3728), .Y(n5293) );
  NBUFFX8_HVT U5646 ( .A(n3851), .Y(n5527) );
  NBUFFX2_HVT U5647 ( .A(AHB_SPI_WRAPPER_sl_rdata[3]), .Y(n5267) );
  NBUFFX2_HVT U5648 ( .A(n4067), .Y(n5268) );
  NBUFFX2_HVT U5649 ( .A(AHB_SPI_WRAPPER_sl_rdata[9]), .Y(n5269) );
  NBUFFX4_HVT U5650 ( .A(AHB_SRAM_WRAPPER_sl_addr[1]), .Y(n5270) );
  NBUFFX2_HVT U5651 ( .A(AHB_SPI_WRAPPER_sl_rdata[8]), .Y(n5271) );
  NBUFFX8_HVT U5652 ( .A(n5458), .Y(n5274) );
  NBUFFX8_HVT U5653 ( .A(n5044), .Y(n5275) );
  NBUFFX8_HVT U5654 ( .A(n5523), .Y(n5458) );
  NBUFFX4_HVT U5655 ( .A(n2792), .Y(n5278) );
  NBUFFX32_HVT U5656 ( .A(n5279), .Y(AHB_SRAM_WRAPPER_sl_wdata[7]) );
  NBUFFX32_HVT U5657 ( .A(n5280), .Y(n2800) );
  NBUFFX2_HVT U5658 ( .A(n4359), .Y(n5281) );
  NBUFFX8_HVT U5659 ( .A(n2792), .Y(n5517) );
  NBUFFX8_HVT U5660 ( .A(n5038), .Y(n5283) );
  NBUFFX2_HVT U5661 ( .A(AHB_I2C_WRAPPER_tx_data[19]), .Y(n5284) );
  NBUFFX2_HVT U5662 ( .A(n4724), .Y(n5285) );
  NBUFFX8_HVT U5663 ( .A(n5250), .Y(n5534) );
  NBUFFX8_HVT U5664 ( .A(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Bit_Counter[0]), .Y(n5509) );
  NBUFFX2_HVT U5665 ( .A(AHB_SPI_WRAPPER_sl_rdata[14]), .Y(n5290) );
  NBUFFX32_HVT U5666 ( .A(n5292), .Y(AHB_SRAM_WRAPPER_sl_wdata[25]) );
  NBUFFX32_HVT U5667 ( .A(n5300), .Y(n2805) );
  NBUFFX32_HVT U5668 ( .A(n5308), .Y(n2716) );
  NBUFFX2_HVT U5669 ( .A(AHB_SPI_WRAPPER_AHB_SPI_SUB_addr_reg[1]), .Y(n5309)
         );
  NBUFFX2_HVT U5670 ( .A(AHB_I2C_WRAPPER_tx_data[25]), .Y(n5311) );
  NBUFFX4_HVT U5671 ( .A(AHB_UART_WRAPPER_sl_wdata[4]), .Y(n5325) );
  NBUFFX8_HVT U5672 ( .A(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Bit_Counter[2]), .Y(n5370) );
  NBUFFX8_HVT U5673 ( .A(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Bit_Counter[1]), .Y(n5470) );
  NBUFFX2_HVT U5674 ( .A(AHB_SPI_WRAPPER_sl_wdata[24]), .Y(n5323) );
  NBUFFX2_HVT U5675 ( .A(AHB_UART_WRAPPER_sl_wdata[26]), .Y(n5324) );
  NBUFFX8_HVT U5676 ( .A(AHB_SPI_WRAPPER_sl_wdata[8]), .Y(n5413) );
  NBUFFX32_HVT U5677 ( .A(n2689), .Y(n5532) );
  NBUFFX2_HVT U5678 ( .A(AHB_I2C_WRAPPER_tx_data[23]), .Y(n5335) );
  NBUFFX32_HVT U5679 ( .A(n5336), .Y(AHB_SRAM_WRAPPER_sl_wdata[24]) );
  NBUFFX2_HVT U5680 ( .A(AHB_I2C_WRAPPER_tx_data[11]), .Y(n5337) );
  NBUFFX2_HVT U5681 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_size[1]), .Y(n5340)
         );
  NBUFFX2_HVT U5682 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_tx_shift[6]), .Y(n5341) );
  NBUFFX8_HVT U5683 ( .A(n4472), .Y(n5524) );
  NBUFFX2_HVT U5684 ( .A(AHB_SPI_WRAPPER_SPI_CONTROLLER_rx_counter[1]), .Y(
        n5342) );
  NBUFFX2_HVT U5685 ( .A(AHB_SPI_WRAPPER_sl_rdata[11]), .Y(n5347) );
  NBUFFX2_HVT U5686 ( .A(AHB_SPI_WRAPPER_sl_rdata[12]), .Y(n5348) );
  NBUFFX4_HVT U5687 ( .A(AHB_UART_WRAPPER_sl_wdata[1]), .Y(n5350) );
  NBUFFX8_HVT U5688 ( .A(n2790), .Y(n5523) );
  NBUFFX32_HVT U5689 ( .A(n5361), .Y(AHB_SRAM_WRAPPER_sl_wdata[22]) );
  NBUFFX2_HVT U5690 ( .A(AHB_I2C_WRAPPER_sl_rdata[27]), .Y(n5363) );
  NBUFFX4_HVT U5691 ( .A(AHB_I2C_WRAPPER_sl_wdata[4]), .Y(n5365) );
  NBUFFX8_HVT U5692 ( .A(AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_STATE[2]), .Y(n5488) );
  NBUFFX8_HVT U5693 ( .A(n4471), .Y(n5371) );
  NBUFFX8_HVT U5694 ( .A(n3953), .Y(n5491) );
  NBUFFX8_HVT U5695 ( .A(n3950), .Y(n5533) );
  NBUFFX4_HVT U5696 ( .A(n2809), .Y(n5376) );
  NBUFFX4_HVT U5697 ( .A(n3412), .Y(n5378) );
  NBUFFX2_HVT U5698 ( .A(AHB_I2C_WRAPPER_tx_data[15]), .Y(n5379) );
  NBUFFX2_HVT U5699 ( .A(n4718), .Y(n5381) );
  NBUFFX2_HVT U5700 ( .A(n2689), .Y(n5383) );
  NBUFFX2_HVT U5701 ( .A(n3964), .Y(n5384) );
  NBUFFX2_HVT U5702 ( .A(n4379), .Y(n5388) );
  NBUFFX2_HVT U5703 ( .A(AHB_I2C_WRAPPER_tx_data[22]), .Y(n5389) );
  NBUFFX2_HVT U5704 ( .A(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[5]), .Y(n5391)
         );
  NBUFFX2_HVT U5705 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_bit_counter[1]), .Y(
        n5394) );
  NBUFFX2_HVT U5706 ( .A(AHB_I2C_WRAPPER_sl_wdata[5]), .Y(n5395) );
  NBUFFX2_HVT U5707 ( .A(n2791), .Y(n5399) );
  NBUFFX2_HVT U5708 ( .A(AHB_I2C_WRAPPER_sl_rdata[30]), .Y(n5400) );
  NBUFFX4_HVT U5709 ( .A(AHB_SPI_WRAPPER_sl_wdata[3]), .Y(n5401) );
  NBUFFX4_HVT U5710 ( .A(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[3]), .Y(n5402)
         );
  NBUFFX4_HVT U5711 ( .A(AHB_SPI_WRAPPER_sl_wdata[7]), .Y(n5403) );
  NBUFFX2_HVT U5712 ( .A(AHB_I2C_WRAPPER_sl_rdata[31]), .Y(n5404) );
  NBUFFX4_HVT U5713 ( .A(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_Byte_Frame[4]), .Y(n5406)
         );
  NBUFFX4_HVT U5714 ( .A(AHB_SPI_WRAPPER_sl_wdata[5]), .Y(n5407) );
  NBUFFX2_HVT U5715 ( .A(AHB_I2C_WRAPPER_tx_data[20]), .Y(n5409) );
  NBUFFX32_HVT U5716 ( .A(n5410), .Y(AHB_SRAM_WRAPPER_sl_wdata[20]) );
  NBUFFX32_HVT U5717 ( .A(n5412), .Y(AHB_SRAM_WRAPPER_sl_wdata[23]) );
  NBUFFX4_HVT U5718 ( .A(n5534), .Y(n5415) );
  NBUFFX4_HVT U5719 ( .A(AHB_UART_WRAPPER_sl_wdata[2]), .Y(n5418) );
  NBUFFX32_HVT U5720 ( .A(n5422), .Y(AHB_SRAM_WRAPPER_sl_wdata[21]) );
  NBUFFX2_HVT U5721 ( .A(n2806), .Y(n5426) );
  NBUFFX2_HVT U5722 ( .A(n2816), .Y(n5427) );
  NBUFFX2_HVT U5723 ( .A(n4711), .Y(n5430) );
  NBUFFX8_HVT U5724 ( .A(n3854), .Y(n5511) );
  NBUFFX2_HVT U5725 ( .A(n4743), .Y(n5435) );
  NBUFFX32_HVT U5726 ( .A(n5450), .Y(n2955) );
  NBUFFX4_HVT U5727 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_SUBSTATE), .Y(n5454)
         );
  NBUFFX32_HVT U5728 ( .A(n5455), .Y(n3376) );
  NBUFFX2_HVT U5729 ( .A(AHB_SPI_WRAPPER_SPI_CONTROLLER_STATE[0]), .Y(n5459)
         );
  NBUFFX4_HVT U5730 ( .A(AHB_SPI_WRAPPER_sl_wdata[0]), .Y(n5462) );
  NBUFFX4_HVT U5731 ( .A(AHB_SPI_WRAPPER_sl_wdata[2]), .Y(n5465) );
  NBUFFX4_HVT U5732 ( .A(n2815), .Y(n5468) );
  NBUFFX4_HVT U5733 ( .A(AHB_SPI_WRAPPER_sl_wdata[4]), .Y(n5469) );
  NBUFFX4_HVT U5734 ( .A(AHB_SPI_WRAPPER_sl_wdata[6]), .Y(n5472) );
  NBUFFX4_HVT U5735 ( .A(n3695), .Y(n5473) );
  NBUFFX4_HVT U5736 ( .A(AHB_UART_WRAPPER_sl_rdata[27]), .Y(n5477) );
  NBUFFX4_HVT U5737 ( .A(AHB_UART_WRAPPER_sl_rdata[26]), .Y(n5478) );
  NBUFFX8_HVT U5738 ( .A(AHB_UART_WRAPPER_sl_rdata[28]), .Y(n5479) );
  NBUFFX4_HVT U5739 ( .A(AHB_UART_WRAPPER_sl_rdata[29]), .Y(n5480) );
  NBUFFX4_HVT U5740 ( .A(AHB_UART_WRAPPER_sl_rdata[31]), .Y(n5481) );
  NBUFFX4_HVT U5741 ( .A(AHB_UART_WRAPPER_sl_rdata[30]), .Y(n5482) );
  NBUFFX2_HVT U5742 ( .A(HREADY), .Y(n5483) );
  NBUFFX4_HVT U5743 ( .A(n2807), .Y(n5486) );
  NBUFFX8_HVT U5744 ( .A(n2720), .Y(n5512) );
  NBUFFX8_HVT U5745 ( .A(n2797), .Y(n5490) );
  NBUFFX2_HVT U5746 ( .A(AHB_UART_WRAPPER_UART_CONTROLLER_u_rx_module_STATE[1]), .Y(n5499) );
  NBUFFX2_HVT U5747 ( .A(n3400), .Y(n5500) );
  NBUFFX2_HVT U5748 ( .A(n2829), .Y(n5502) );
  NBUFFX2_HVT U5749 ( .A(n5195), .Y(n5503) );
  NBUFFX4_HVT U5750 ( .A(AHB_I2C_WRAPPER_I2C_CONTROLLER_STATE[0]), .Y(n5505)
         );
  NBUFFX4_HVT U5751 ( .A(n4396), .Y(n5506) );
  NBUFFX2_HVT U5752 ( .A(
        AHB_UART_WRAPPER_UART_CONTROLLER_u_tx_module_Byte_Counter[1]), .Y(
        n5507) );
  NBUFFX32_HVT U5753 ( .A(n2708), .Y(n5530) );
  NBUFFX2_HVT U5754 ( .A(n4744), .Y(n5510) );
  NBUFFX8_HVT U5755 ( .A(n2789), .Y(n5525) );
  NBUFFX32_HVT U5756 ( .A(n2814), .Y(n5518) );
  NBUFFX8_HVT U5757 ( .A(n2714), .Y(n5528) );
  NBUFFX4_HVT U5758 ( .A(n3730), .Y(n5526) );
  NBUFFX4_HVT U5759 ( .A(n4249), .Y(n5531) );
endmodule


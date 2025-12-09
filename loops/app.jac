# ============================================
# LOOPS IN JAC-LANG (ONELANG)
# React/JS uses: for(let i=0; i<5; i++) {}
# JAC uses: for i=0 to i<5 by i+=1 {}
# NOTE: range() does NOT work in onelang!
# ============================================

cl import from react {useState}

cl {
    # Styles for consistent UI
    let styles = {
        "container": {
            "fontFamily": "Arial, sans-serif",
            "maxWidth": "900px",
            "margin": "0 auto",
            "padding": "20px"
        },
        "section": {
            "marginBottom": "30px",
            "padding": "20px",
            "backgroundColor": "#f8f9fa",
            "borderRadius": "8px",
            "border": "1px solid #dee2e6"
        },
        "title": {
            "color": "#333",
            "borderLeft": "4px solid #007bff",
            "paddingLeft": "10px",
            "marginBottom": "15px"
        },
        "code": {
            "backgroundColor": "#2d2d2d",
            "color": "#f8f8f2",
            "padding": "15px",
            "borderRadius": "5px",
            "fontFamily": "monospace",
            "fontSize": "13px",
            "overflowX": "auto",
            "marginBottom": "15px",
            "whiteSpace": "pre-wrap"
        },
        "button": {
            "padding": "10px 20px",
            "marginRight": "10px",
            "marginBottom": "10px",
            "backgroundColor": "#007bff",
            "color": "white",
            "border": "none",
            "borderRadius": "5px",
            "cursor": "pointer"
        },
        "result": {
            "padding": "15px",
            "backgroundColor": "#e8f5e9",
            "borderRadius": "5px",
            "marginTop": "10px",
            "fontFamily": "monospace"
        },
        "warning": {
            "padding": "15px",
            "backgroundColor": "#fff3cd",
            "border": "1px solid #ffc107",
            "borderRadius": "5px",
            "marginBottom": "15px"
        },
        "comparison": {
            "display": "grid",
            "gridTemplateColumns": "1fr 1fr",
            "gap": "15px",
            "marginBottom": "15px"
        }
    };

    # ============================================
    # Example 1: BASIC COUNTER LOOP
    # The fundamental loop syntax in JAC
    # ============================================
    def Example1_BasicCounterLoop() -> any {
        let [output, setOutput] = useState([]);

        def runLoop() -> None {
            let results = [];
            
            # JAC counter-based loop syntax
            for i=0 to i<5 by i+=1 {
                results = results.concat(["Iteration " + i.toString()]);
            }
            
            setOutput(results);
        }

        let codeText = "# JAC-Lang counter loop (0 to 4)\nfor i=0 to i<5 by i+=1 {\n    console.log('Iteration', i);\n}\n\n# Breakdown:\n# i=0      → Start value\n# i<5      → Condition (while true, loop continues)\n# i+=1     → Increment after each iteration";

        def renderItem(item: str, index: int) -> any {
            return <div key={index}>{item}</div>;
        }

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>1. Basic Counter Loop (0 to 4)</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <button style={styles["button"]} onClick={runLoop}>
                    Run Loop
                </button>
                
                {output.length > 0 and (
                    <div style={styles["result"]}>
                        <strong>Output:</strong>
                        {output.map(renderItem)}
                    </div>
                )}
            </div>
        );
    }

    # ============================================
    # Example 2: LOOP WITH DIFFERENT START VALUES
    # Starting from values other than 0
    # ============================================
    def Example2_DifferentStartValues() -> any {
        let [output, setOutput] = useState([]);

        def runLoop(start: int, end: int) -> None {
            let results = [];
            
            # Loop starting from custom value
            for i=start to i<=end by i+=1 {
                results = results.concat([i]);
            }
            
            setOutput(results);
        }

        let codeText = "# Loop from 1 to 5 (inclusive)\nfor i=1 to i<=5 by i+=1 {\n    console.log(i);  # Prints: 1, 2, 3, 4, 5\n}\n\n# Loop from 10 to 15\nfor i=10 to i<=15 by i+=1 {\n    console.log(i);  # Prints: 10, 11, 12, 13, 14, 15\n}";

        def renderItem(item: int, index: int) -> any {
            return <span key={index} style={{ "marginRight": "10px", "padding": "5px", "backgroundColor": "#007bff", "color": "white", "borderRadius": "3px" }}>{item}</span>;
        }

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>2. Loop with Different Start Values</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <button style={styles["button"]} onClick={lambda: runLoop(1, 5)}>
                    Loop 1 to 5
                </button>
                <button style={styles["button"]} onClick={lambda: runLoop(10, 15)}>
                    Loop 10 to 15
                </button>
                <button style={styles["button"]} onClick={lambda: runLoop(100, 105)}>
                    Loop 100 to 105
                </button>
                
                {output.length > 0 and (
                    <div style={styles["result"]}>
                        <strong>Numbers: </strong>
                        {output.map(renderItem)}
                    </div>
                )}
            </div>
        );
    }

    # ============================================
    # Example 3: LOOP WITH STEP/INCREMENT
    # Incrementing by values other than 1
    # ============================================
    def Example3_CustomIncrement() -> any {
        let [output, setOutput] = useState([]);
        let [stepInfo, setStepInfo] = useState("");

        def runLoop(step: int) -> None {
            let results = [];
            
            # Loop with custom step
            for i=0 to i<=20 by i+=step {
                results = results.concat([i]);
            }
            
            setOutput(results);
            setStepInfo("Step by " + step.toString());
        }

        let codeText = "# Increment by 2 (even numbers)\nfor i=0 to i<=10 by i+=2 {\n    console.log(i);  # Prints: 0, 2, 4, 6, 8, 10\n}\n\n# Increment by 5\nfor i=0 to i<=20 by i+=5 {\n    console.log(i);  # Prints: 0, 5, 10, 15, 20\n}";

        def renderItem(item: int, index: int) -> any {
            return <span key={index} style={{ "marginRight": "8px", "padding": "5px 10px", "backgroundColor": "#28a745", "color": "white", "borderRadius": "3px" }}>{item}</span>;
        }

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>3. Loop with Custom Step/Increment</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <button style={styles["button"]} onClick={lambda: runLoop(1)}>
                    Step by 1
                </button>
                <button style={styles["button"]} onClick={lambda: runLoop(2)}>
                    Step by 2 (Even)
                </button>
                <button style={styles["button"]} onClick={lambda: runLoop(5)}>
                    Step by 5
                </button>
                <button style={styles["button"]} onClick={lambda: runLoop(3)}>
                    Step by 3
                </button>
                
                {output.length > 0 and (
                    <div style={styles["result"]}>
                        <strong>{stepInfo}: </strong>
                        <div style={{ "marginTop": "10px" }}>
                            {output.map(renderItem)}
                        </div>
                    </div>
                )}
            </div>
        );
    }

    # ============================================
    # Example 4: COUNTDOWN LOOP (DECREMENT)
    # Looping backwards
    # ============================================
    def Example4_CountdownLoop() -> any {
        let [output, setOutput] = useState([]);

        def runCountdown(start: int) -> None {
            let results = [];
            
            # Countdown using decrement
            for i=start to i>=0 by i-=1 {
                results = results.concat([i]);
            }
            results = results.concat(["🚀 Liftoff!"]);
            
            setOutput(results);
        }

        let codeText = "# Countdown from 5 to 0\nfor i=5 to i>=0 by i-=1 {\n    console.log(i);  # Prints: 5, 4, 3, 2, 1, 0\n}\n\n# Countdown by 2\nfor i=10 to i>=0 by i-=2 {\n    console.log(i);  # Prints: 10, 8, 6, 4, 2, 0\n}";

        def renderItem(item: any, index: int) -> any {
            return <div key={index} style={{ "fontSize": "18px", "marginBottom": "5px" }}>{item}</div>;
        }

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>4. Countdown Loop (Decrement)</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <button style={styles["button"]} onClick={lambda: runCountdown(5)}>
                    Countdown from 5
                </button>
                <button style={styles["button"]} onClick={lambda: runCountdown(10)}>
                    Countdown from 10
                </button>
                
                {output.length > 0 and (
                    <div style={styles["result"]}>
                        {output.map(renderItem)}
                    </div>
                )}
            </div>
        );
    }

    # ============================================
    # Example 5: FOR-IN LOOP (Iterating Arrays)
    # Looping through array elements
    # ============================================
    def Example5_ForInLoop() -> any {
        let [output, setOutput] = useState([]);

        let fruits = ["Apple", "Banana", "Cherry", "Date", "Elderberry"];
        let numbers = [10, 20, 30, 40, 50];

        def loopFruits() -> None {
            let results = [];
            
            # For-in loop for arrays
            for fruit in fruits {
                results = results.concat(["🍎 " + fruit]);
            }
            
            setOutput(results);
        }

        def loopNumbers() -> None {
            let results = [];
            let total = 0;
            
            for num in numbers {
                total = total + num;
                results = results.concat(["Added " + num.toString() + " → Total: " + total.toString()]);
            }
            
            setOutput(results);
        }

        let codeText = "# For-in loop (iterate array elements)\nlet fruits = ['Apple', 'Banana', 'Cherry'];\n\nfor fruit in fruits {\n    console.log(fruit);\n}\n# Prints: Apple, Banana, Cherry\n\n# Sum numbers\nlet total = 0;\nfor num in numbers {\n    total = total + num;\n}";

        def renderItem(item: str, index: int) -> any {
            return <div key={index}>{item}</div>;
        }

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>5. For-In Loop (Iterating Arrays)</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <button style={styles["button"]} onClick={loopFruits}>
                    Loop Fruits
                </button>
                <button style={styles["button"]} onClick={loopNumbers}>
                    Sum Numbers
                </button>
                
                {output.length > 0 and (
                    <div style={styles["result"]}>
                        {output.map(renderItem)}
                    </div>
                )}
            </div>
        );
    }

    # ============================================
    # Example 6: NESTED LOOPS
    # Loop inside a loop
    # ============================================
    def Example6_NestedLoops() -> any {
        let [output, setOutput] = useState([]);

        def runMultiplicationTable() -> None {
            let results = [];
            
            for i=1 to i<=5 by i+=1 {
                let row = "";
                for j=1 to j<=5 by j+=1 {
                    let product = i * j;
                    row = row + (product.toString() + "\t");
                }
                results = results.concat([row]);
            }
            
            setOutput(results);
        }

        def runGrid() -> None {
            let results = [];
            
            for row=0 to row<3 by row+=1 {
                for col=0 to col<3 by col+=1 {
                    results = results.concat(["[" + row.toString() + "," + col.toString() + "]"]);
                }
            }
            
            setOutput(results);
        }

        let codeText = "# Nested loops - Multiplication table\nfor i=1 to i<=5 by i+=1 {\n    for j=1 to j<=5 by j+=1 {\n        let product = i * j;\n        console.log(i + ' x ' + j + ' = ' + product);\n    }\n}\n\n# Grid coordinates\nfor row=0 to row<3 by row+=1 {\n    for col=0 to col<3 by col+=1 {\n        console.log('[' + row + ',' + col + ']');\n    }\n}";

        def renderItem(item: str, index: int) -> any {
            return <div key={index} style={{ "fontFamily": "monospace" }}>{item}</div>;
        }

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>6. Nested Loops</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <button style={styles["button"]} onClick={runMultiplicationTable}>
                    Multiplication Table (5x5)
                </button>
                <button style={styles["button"]} onClick={runGrid}>
                    Grid Coordinates (3x3)
                </button>
                
                {output.length > 0 and (
                    <div style={styles["result"]}>
                        {output.map(renderItem)}
                    </div>
                )}
            </div>
        );
    }

    # ============================================
    # Example 7: WHILE LOOP
    # Loop while condition is true
    # ============================================
    def Example7_WhileLoop() -> any {
        let [output, setOutput] = useState([]);

        def runWhileLoop() -> None {
            let results = [];
            let count = 0;
            
            while count < 5 {
                results = results.concat(["Count is: " + count.toString()]);
                count = count + 1;
            }
            results = results.concat(["Loop ended! Final count: " + count.toString()]);
            
            setOutput(results);
        }

        def runUntilCondition() -> None {
            let results = [];
            let value = 1;
            
            # Double until reaches 100
            while value < 100 {
                results = results.concat([value.toString()]);
                value = value * 2;
            }
            results = results.concat(["Stopped at: " + value.toString()]);
            
            setOutput(results);
        }

        let codeText = "# While loop - basic\nlet count = 0;\nwhile count < 5 {\n    console.log('Count:', count);\n    count = count + 1;\n}\n\n# While loop - double until 100\nlet value = 1;\nwhile value < 100 {\n    console.log(value);\n    value = value * 2;\n}";

        def renderItem(item: str, index: int) -> any {
            return <div key={index}>{item}</div>;
        }

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>7. While Loop</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <button style={styles["button"]} onClick={runWhileLoop}>
                    Count to 5
                </button>
                <button style={styles["button"]} onClick={runUntilCondition}>
                    Double Until 100
                </button>
                
                {output.length > 0 and (
                    <div style={styles["result"]}>
                        {output.map(renderItem)}
                    </div>
                )}
            </div>
        );
    }

    # ============================================
    # Example 8: BUILDING ARRAYS WITH LOOPS
    # Creating arrays using counter loops
    # ============================================
    def Example8_BuildingArrays() -> any {
        let [output, setOutput] = useState([]);

        def buildSquares() -> None {
            let squares = [];
            
            # Build array of squares
            for i=1 to i<=10 by i+=1 {
                let square = i * i;
                squares = squares.concat([square]);
            }
            
            setOutput(squares);
        }

        def buildEvenNumbers() -> None {
            let evens = [];
            
            # Build array of even numbers
            for i=2 to i<=20 by i+=2 {
                evens = evens.concat([i]);
            }
            
            setOutput(evens);
        }

        def buildFibonacci() -> None {
            let fib = [0, 1];
            
            for i=2 to i<10 by i+=1 {
                let next = fib[i-1] + fib[i-2];
                fib = fib.concat([next]);
            }
            
            setOutput(fib);
        }

        let codeText = "# Build array of squares\nlet squares = [];\nfor i=1 to i<=10 by i+=1 {\n    let square = i * i;\n    squares = squares.concat([square]);\n}\n# Result: [1, 4, 9, 16, 25, ...]\n\n# Build even numbers\nlet evens = [];\nfor i=2 to i<=20 by i+=2 {\n    evens = evens.concat([i]);\n}";

        def renderItem(item: int, index: int) -> any {
            return <span key={index} style={{ "marginRight": "8px", "padding": "5px 10px", "backgroundColor": "#6f42c1", "color": "white", "borderRadius": "3px" }}>{item}</span>;
        }

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>8. Building Arrays with Loops</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <button style={styles["button"]} onClick={buildSquares}>
                    Squares (1-10)
                </button>
                <button style={styles["button"]} onClick={buildEvenNumbers}>
                    Even Numbers (2-20)
                </button>
                <button style={styles["button"]} onClick={buildFibonacci}>
                    Fibonacci (10 terms)
                </button>
                
                {output.length > 0 and (
                    <div style={styles["result"]}>
                        <strong>Array: </strong>
                        <div style={{ "marginTop": "10px" }}>
                            {output.map(renderItem)}
                        </div>
                    </div>
                )}
            </div>
        );
    }

    # ============================================
    # Example 9: LOOP WITH INDEX + ARRAY
    # Access array by index using counter loop
    # ============================================
    def Example9_LoopWithIndex() -> any {
        let [output, setOutput] = useState([]);

        let colors = ["Red", "Green", "Blue", "Yellow", "Purple"];

        def loopWithIndex() -> None {
            let results = [];
            
            # Using counter loop to access by index
            for i=0 to i<colors.length by i+=1 {
                results = results.concat(["Index " + i.toString() + ": " + colors[i]]);
            }
            
            setOutput(results);
        }

        def loopReverse() -> None {
            let results = [];
            
            # Loop array in reverse
            for i=colors.length-1 to i>=0 by i-=1 {
                results = results.concat(["Index " + i.toString() + ": " + colors[i]]);
            }
            
            setOutput(results);
        }

        def loopEveryOther() -> None {
            let results = [];
            
            # Skip every other element
            for i=0 to i<colors.length by i+=2 {
                results = results.concat(["Index " + i.toString() + ": " + colors[i]]);
            }
            
            setOutput(results);
        }

        let codeText = "# Access array by index\nlet colors = ['Red', 'Green', 'Blue', 'Yellow', 'Purple'];\n\nfor i=0 to i<colors.length by i+=1 {\n    console.log('Index', i, ':', colors[i]);\n}\n\n# Reverse order\nfor i=colors.length-1 to i>=0 by i-=1 {\n    console.log(colors[i]);\n}";

        def renderItem(item: str, index: int) -> any {
            return <div key={index}>{item}</div>;
        }

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>9. Loop with Index + Array Access</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <p>Colors: {JSON.stringify(colors)}</p>
                
                <button style={styles["button"]} onClick={loopWithIndex}>
                    Loop Forward
                </button>
                <button style={styles["button"]} onClick={loopReverse}>
                    Loop Reverse
                </button>
                <button style={styles["button"]} onClick={loopEveryOther}>
                    Every Other
                </button>
                
                {output.length > 0 and (
                    <div style={styles["result"]}>
                        {output.map(renderItem)}
                    </div>
                )}
            </div>
        );
    }

    # ============================================
    # Example 10: PRACTICAL EXAMPLES
    # Real-world use cases
    # ============================================
    def Example10_PracticalExamples() -> any {
        let [output, setOutput] = useState([]);
        let [example, setExample] = useState("");

        def calculateSum() -> None {
            let sum = 0;
            let results = [];
            
            for i=1 to i<=100 by i+=1 {
                sum = sum + i;
            }
            
            results = results.concat(["Sum of 1 to 100 = " + sum.toString()]);
            setOutput(results);
            setExample("Sum");
        }

        def calculateFactorial() -> None {
            let n = 5;
            let factorial = 1;
            let results = [];
            
            for i=1 to i<=n by i+=1 {
                factorial = factorial * i;
                results = results.concat([i.toString() + "! = " + factorial.toString()]);
            }
            
            setOutput(results);
            setExample("Factorial");
        }

        def generateStars() -> None {
            let results = [];
            
            for i=1 to i<=5 by i+=1 {
                let stars = "";
                for j=0 to j<i by j+=1 {
                    stars = stars + "⭐";
                }
                results = results.concat([stars]);
            }
            
            setOutput(results);
            setExample("Stars");
        }

        def findPrimes() -> None {
            let results = [];
            
            for num=2 to num<=30 by num+=1 {
                let isPrime = True;
                for i=2 to i<num by i+=1 {
                    if num % i == 0 {
                        isPrime = False;
                    }
                }
                if isPrime {
                    results = results.concat([num]);
                }
            }
            
            setOutput(results);
            setExample("Primes");
        }

        let codeText = "# Sum 1 to 100\nlet sum = 0;\nfor i=1 to i<=100 by i+=1 {\n    sum = sum + i;\n}\n\n# Factorial\nlet factorial = 1;\nfor i=1 to i<=n by i+=1 {\n    factorial = factorial * i;\n}\n\n# Star pattern\nfor i=1 to i<=5 by i+=1 {\n    let stars = '';\n    for j=0 to j<i by j+=1 {\n        stars = stars + '⭐';\n    }\n}";

        def renderItem(item: any, index: int) -> any {
            return <div key={index} style={{ "fontSize": "16px" }}>{item}</div>;
        }

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>10. Practical Loop Examples</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <button style={styles["button"]} onClick={calculateSum}>
                    Sum 1-100
                </button>
                <button style={styles["button"]} onClick={calculateFactorial}>
                    Factorial 5!
                </button>
                <button style={styles["button"]} onClick={generateStars}>
                    Star Pattern
                </button>
                <button style={styles["button"]} onClick={findPrimes}>
                    Prime Numbers (2-30)
                </button>
                
                {output.length > 0 and (
                    <div style={styles["result"]}>
                        <strong>{example} Result:</strong>
                        <div style={{ "marginTop": "10px" }}>
                            {output.map(renderItem)}
                        </div>
                    </div>
                )}
            </div>
        );
    }

    # ============================================
    # SYNTAX COMPARISON COMPONENT
    # ============================================
    def SyntaxComparison() -> any {
        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>📋 Quick Syntax Reference</h3>
                
                <div style={styles["warning"]}>
                    <strong>⚠️ Important:</strong> <code>range()</code> does NOT work in JAC-Lang/Onelang!
                    <br />
                    Use counter-based loops instead: <code>for i=0 to i&lt;5 by i+=1 {"{}"}</code>
                </div>
                
                <table style={{ "width": "100%", "borderCollapse": "collapse", "marginTop": "15px" }}>
                    <thead>
                        <tr style={{ "backgroundColor": "#333", "color": "white" }}>
                            <th style={{ "padding": "12px", "textAlign": "left" }}>Loop Type</th>
                            <th style={{ "padding": "12px", "textAlign": "left" }}>JAC-Lang Syntax</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr style={{ "backgroundColor": "#f8f9fa" }}>
                            <td style={{ "padding": "12px", "border": "1px solid #ddd" }}>Basic Counter</td>
                            <td style={{ "padding": "12px", "border": "1px solid #ddd", "fontFamily": "monospace" }}>for i=0 to i&lt;5 by i+=1 {"{...}"}</td>
                        </tr>
                        <tr>
                            <td style={{ "padding": "12px", "border": "1px solid #ddd" }}>Inclusive End</td>
                            <td style={{ "padding": "12px", "border": "1px solid #ddd", "fontFamily": "monospace" }}>for i=1 to i&lt;=10 by i+=1 {"{...}"}</td>
                        </tr>
                        <tr style={{ "backgroundColor": "#f8f9fa" }}>
                            <td style={{ "padding": "12px", "border": "1px solid #ddd" }}>Custom Step</td>
                            <td style={{ "padding": "12px", "border": "1px solid #ddd", "fontFamily": "monospace" }}>for i=0 to i&lt;10 by i+=2 {"{...}"}</td>
                        </tr>
                        <tr>
                            <td style={{ "padding": "12px", "border": "1px solid #ddd" }}>Countdown</td>
                            <td style={{ "padding": "12px", "border": "1px solid #ddd", "fontFamily": "monospace" }}>for i=10 to i&gt;=0 by i-=1 {"{...}"}</td>
                        </tr>
                        <tr style={{ "backgroundColor": "#f8f9fa" }}>
                            <td style={{ "padding": "12px", "border": "1px solid #ddd" }}>For-In (Array)</td>
                            <td style={{ "padding": "12px", "border": "1px solid #ddd", "fontFamily": "monospace" }}>for item in array {"{...}"}</td>
                        </tr>
                        <tr>
                            <td style={{ "padding": "12px", "border": "1px solid #ddd" }}>While</td>
                            <td style={{ "padding": "12px", "border": "1px solid #ddd", "fontFamily": "monospace" }}>while condition {"{...}"}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        );
    }

    # ============================================
    # MAIN APP COMPONENT
    # ============================================
    def app() -> any {
        return (
            <div style={styles["container"]}>
                <h1 style={{ "textAlign": "center", "color": "#333" }}>
                    🔄 Loops in JAC-Lang (Onelang)
                </h1>
                <p style={{ "textAlign": "center", "color": "#666", "marginBottom": "30px" }}>
                    Master counter-based loops and iterations in JAC-Lang
                </p>
                
                <div style={{ "backgroundColor": "#e7f3ff", "padding": "15px", "borderRadius": "8px", "marginBottom": "20px" }}>
                    <h4>🔑 Key Syntax:</h4>
                    <p><strong>JavaScript:</strong> <code>for(let i=0; i&lt;5; i++) {"{}"}</code></p>
                    <p><strong>JAC-Lang:</strong> <code>for i=0 to i&lt;5 by i+=1 {"{}"}</code></p>
                    <p style={{ "color": "#dc3545", "marginTop": "10px" }}>
                        <strong>⚠️ Note:</strong> <code>range()</code> does NOT work in Onelang!
                    </p>
                </div>

                <SyntaxComparison />
                <Example1_BasicCounterLoop />
                <Example2_DifferentStartValues />
                <Example3_CustomIncrement />
                <Example4_CountdownLoop />
                <Example5_ForInLoop />
                <Example6_NestedLoops />
                <Example7_WhileLoop />
                <Example8_BuildingArrays />
                <Example9_LoopWithIndex />
                <Example10_PracticalExamples />
            </div>
        );
    }
}

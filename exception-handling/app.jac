
# ============================================
# EXCEPTION HANDLING IN JAC-LANG (ONELANG)
# React uses: try { } catch(e) { } finally { }
# JAC uses: try { } except { } finally { }
# ============================================

cl import from react {useState, useEffect}

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
        "dangerButton": {
            "padding": "10px 20px",
            "marginRight": "10px",
            "marginBottom": "10px",
            "backgroundColor": "#dc3545",
            "color": "white",
            "border": "none",
            "borderRadius": "5px",
            "cursor": "pointer"
        },
        "result": {
            "padding": "10px",
            "backgroundColor": "#e8f5e9",
            "borderRadius": "5px",
            "marginTop": "10px"
        },
        "error": {
            "padding": "10px",
            "backgroundColor": "#f8d7da",
            "color": "#721c24",
            "borderRadius": "5px",
            "marginTop": "10px"
        },
        "success": {
            "padding": "10px",
            "backgroundColor": "#d4edda",
            "color": "#155724",
            "borderRadius": "5px",
            "marginTop": "10px"
        }
    };

    # ============================================
    # Example 1: BASIC TRY/EXCEPT
    # Handling division by zero
    # ============================================
    def Example1_BasicTryExcept() -> any {
        let [result, setResult] = useState("");
        let [error, setError] = useState("");

        # Function that might throw an error
        def divideNumbers(a: int, b: int) -> None {
            setError("");
            setResult("");
            
            try {
                if b == 0 {
                    raise Exception("Cannot divide by zero!");
                }
                let answer = a / b;
                setResult("Result: " + (answer.toString()));
            } except Exception as e {
                setError("Error: " + (e.toString()));
            }
        }

        let codeText = "# JAC-Lang try/except\ntry {\n    if b == 0 {\n        raise Exception('Cannot divide by zero!');\n    }\n    let answer = a / b;\n} except Exception as e {\n    setError('Error: ' + (e.toString()));\n}";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>1. Basic Try/Except - Division</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <button style={styles["button"]} onClick={lambda: divideNumbers(10, 2)}>
                    10 ÷ 2 (Safe)
                </button>
                <button style={styles["dangerButton"]} onClick={lambda: divideNumbers(10, 0)}>
                    10 ÷ 0 (Error!)
                </button>
                
                {result and <div style={styles["success"]}>{result}</div>}
                {error and <div style={styles["error"]}>{error}</div>}
            </div>
        );
    }

    # ============================================
    # Example 2: TRY/EXCEPT/FINALLY
    # Finally always runs (cleanup)
    # ============================================
    def Example2_TryExceptFinally() -> any {
        let [status, setStatus] = useState("");
        let [logs, setLogs] = useState([]);

        def addLog(message: str) -> None {
            setLogs(logs.concat([message]));
        }

        def processData(shouldFail: bool) -> None {
            setLogs([]);
            setStatus("processing");
            
            try {
                addLog("📝 Starting process...");
                
                if shouldFail {
                    raise Exception("Something went wrong!");
                }
                
                addLog("✅ Process completed successfully!");
                setStatus("success");
            } except Exception as e {
                addLog("❌ Error: " + (e.toString()));
                setStatus("error");
            } finally {
                # This ALWAYS runs, whether error or not
                addLog("🧹 Cleanup: Finally block executed!");
            }
        }

        let codeText = "# try/except/finally\ntry {\n    # risky code\n} except Exception as e {\n    # handle error\n} finally {\n    # ALWAYS runs (cleanup)\n}";

        def renderLog(log: str, index: int) -> any {
            return <li key={index}>{log}</li>;
        }

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>2. Try/Except/Finally - Cleanup</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <button style={styles["button"]} onClick={lambda: processData(False)}>
                    Process (Success)
                </button>
                <button style={styles["dangerButton"]} onClick={lambda: processData(True)}>
                    Process (Will Fail)
                </button>
                
                <div style={styles["result"]}>
                    <strong>Status:</strong> {status}
                    <ul>{logs.map(renderLog)}</ul>
                </div>
            </div>
        );
    }

    # ============================================
    # Example 3: HANDLING JSON PARSE ERRORS
    # Common real-world scenario
    # ============================================
    def Example3_JsonParseError() -> any {
        let [parsedData, setParsedData] = useState(None);
        let [error, setError] = useState("");

        def parseJson(jsonString: str) -> None {
            setError("");
            setParsedData(None);
            
            try {
                let data = JSON.parse(jsonString);
                setParsedData(data);
            } except Exception as e {
                # Generic except - catch any error
                setError("Invalid JSON format! Please check your input.");
            }
        }

        let validJson = '{"name": "John", "age": 30}';
        let invalidJson = '{name: invalid}';

        let codeText = "# Parsing JSON safely\ntry {\n    let data = JSON.parse(jsonString);\n    setParsedData(data);\n} except {\n    setError('Invalid JSON!');\n}";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>3. JSON Parse Error Handling</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <button style={styles["button"]} onClick={lambda: parseJson(validJson)}>
                    Parse Valid JSON
                </button>
                <button style={styles["dangerButton"]} onClick={lambda: parseJson(invalidJson)}>
                    Parse Invalid JSON
                </button>
                
                {parsedData and (
                    <div style={styles["success"]}>
                        ✅ Parsed: Name = {parsedData["name"]}, Age = {parsedData["age"]}
                    </div>
                )}
                {error and <div style={styles["error"]}>❌ {error}</div>}
            </div>
        );
    }

    # ============================================
    # Example 4: HANDLING ARRAY INDEX ERRORS
    # Accessing items safely
    # ============================================
    def Example4_ArrayIndexError() -> any {
        let [result, setResult] = useState("");
        let [error, setError] = useState("");

        let fruits = ["Apple", "Banana", "Cherry"];

        def getItem(index: int) -> None {
            setError("");
            setResult("");
            
            try {
                if index < 0 or index >= fruits.length {
                    raise Exception("Index " + (index.toString()) + " is out of bounds! Array has " + (fruits.length.toString()) + " items.");
                }
                let item = fruits[index];
                setResult("Item at index " + (index.toString()) + ": " + item);
            } except Exception as e {
                setError((e.toString()));
            }
        }

        let codeText = "# Safe array access\nlet fruits = ['Apple', 'Banana', 'Cherry'];\n\ntry {\n    if index < 0 or index >= fruits.length {\n        raise Exception('Index out of bounds!');\n    }\n    let item = fruits[index];\n} except Exception as e {\n    setError((e.toString()));\n}";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>4. Array Index Error Handling</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <p>Array: {JSON.stringify(fruits)}</p>
                
                <button style={styles["button"]} onClick={lambda: getItem(0)}>
                    Get Index 0
                </button>
                <button style={styles["button"]} onClick={lambda: getItem(1)}>
                    Get Index 1
                </button>
                <button style={styles["button"]} onClick={lambda: getItem(2)}>
                    Get Index 2
                </button>
                <button style={styles["dangerButton"]} onClick={lambda: getItem(5)}>
                    Get Index 5 (Error!)
                </button>
                <button style={styles["dangerButton"]} onClick={lambda: getItem(-1)}>
                    Get Index -1 (Error!)
                </button>
                
                {result and <div style={styles["success"]}>✅ {result}</div>}
                {error and <div style={styles["error"]}>❌ {error}</div>}
            </div>
        );
    }

    # ============================================
    # Example 5: HANDLING OBJECT KEY ERRORS
    # Safely accessing object properties
    # ============================================
    def Example5_ObjectKeyError() -> any {
        let [result, setResult] = useState("");
        let [error, setError] = useState("");

        let user = {
            "name": "Alice",
            "email": "alice@example.com"
        };

        def getProperty(key: str) -> None {
            setError("");
            setResult("");
            
            try {
                let value = user[key];
                if value == undefined {
                    raise Exception("Property '" + key + "' does not exist!");
                }
                setResult(key + ": " + value);
            } except Exception as e {
                setError((e.toString()));
            }
        }

        let codeText = "# Safe object property access\nlet user = { 'name': 'Alice', 'email': '...' };\n\ntry {\n    let value = user[key];\n    if value == undefined {\n        raise Exception('Property not found!');\n    }\n} except Exception as e {\n    setError((e.toString()));\n}";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>5. Object Key Error Handling</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <p>User: {JSON.stringify(user)}</p>
                
                <button style={styles["button"]} onClick={lambda: getProperty("name")}>
                    Get name
                </button>
                <button style={styles["button"]} onClick={lambda: getProperty("email")}>
                    Get email
                </button>
                <button style={styles["dangerButton"]} onClick={lambda: getProperty("phone")}>
                    Get phone (Error!)
                </button>
                <button style={styles["dangerButton"]} onClick={lambda: getProperty("age")}>
                    Get age (Error!)
                </button>
                
                {result and <div style={styles["success"]}>✅ {result}</div>}
                {error and <div style={styles["error"]}>❌ {error}</div>}
            </div>
        );
    }

    # ============================================
    # Example 6: INPUT VALIDATION with EXCEPTIONS
    # Form validation using try/except
    # ============================================
    def Example6_InputValidation() -> any {
        let [username, setUsername] = useState("");
        let [email, setEmail] = useState("");
        let [age, setAge] = useState("");
        let [result, setResult] = useState("");
        let [error, setError] = useState("");

        def validateAndSubmit() -> None {
            setError("");
            setResult("");
            
            try {
                # Validate username
                if username.length < 3 {
                    raise Exception("Username must be at least 3 characters!");
                }
                
                # Validate email (simple check)
                if not email.includes("@") {
                    raise Exception("Email must contain @ symbol!");
                }
                
                # Validate age
                let ageNum = parseInt(age);
                if isNaN(ageNum) {
                    raise Exception("Age must be a number!");
                }
                if ageNum < 0 or ageNum > 150 {
                    raise Exception("Age must be between 0 and 150!");
                }
                
                # All validations passed
                setResult("✅ Form submitted! Username: " + username + ", Email: " + email + ", Age: " + age);
                
            } except Exception as e {
                setError((e.toString()));
            }
        }

        let codeText = "# Form validation with exceptions\ntry {\n    if username.length < 3 {\n        raise Exception('Username too short!');\n    }\n    if not email.includes('@') {\n        raise Exception('Invalid email!');\n    }\n    # Success\n} except Exception as e {\n    setError((e.toString()));\n}";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>6. Input Validation with Exceptions</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <div style={{ "marginBottom": "10px" }}>
                    <input
                        type="text"
                        placeholder="Username (min 3 chars)"
                        value={username}
                        onChange={lambda e: any -> None { setUsername(e.target.value); }}
                        style={{ "padding": "8px", "marginRight": "10px", "width": "200px" }}
                    />
                </div>
                <div style={{ "marginBottom": "10px" }}>
                    <input
                        type="text"
                        placeholder="Email (must have @)"
                        value={email}
                        onChange={lambda e: any -> None { setEmail(e.target.value); }}
                        style={{ "padding": "8px", "marginRight": "10px", "width": "200px" }}
                    />
                </div>
                <div style={{ "marginBottom": "10px" }}>
                    <input
                        type="text"
                        placeholder="Age (number)"
                        value={age}
                        onChange={lambda e: any -> None { setAge(e.target.value); }}
                        style={{ "padding": "8px", "marginRight": "10px", "width": "200px" }}
                    />
                </div>
                
                <button style={styles["button"]} onClick={validateAndSubmit}>
                    Submit Form
                </button>
                
                {result and <div style={styles["success"]}>{result}</div>}
                {error and <div style={styles["error"]}>❌ {error}</div>}
            </div>
        );
    }

    # ============================================
    # Example 7: NESTED TRY/EXCEPT
    # Handling multiple potential errors
    # ============================================
    def Example7_NestedTryExcept() -> any {
        let [logs, setLogs] = useState([]);

        def addLog(msg: str) -> None {
            setLogs(logs.concat([msg]));
        }

        def processSteps(failStep: int) -> None {
            setLogs([]);
            
            try {
                addLog("🚀 Starting Step 1...");
                if failStep == 1 {
                    raise Exception("Step 1 failed!");
                }
                addLog("✅ Step 1 completed");
                
                try {
                    addLog("🚀 Starting Step 2...");
                    if failStep == 2 {
                        raise Exception("Step 2 failed!");
                    }
                    addLog("✅ Step 2 completed");
                    
                    try {
                        addLog("🚀 Starting Step 3...");
                        if failStep == 3 {
                            raise Exception("Step 3 failed!");
                        }
                        addLog("✅ Step 3 completed");
                        addLog("🎉 All steps completed successfully!");
                    } except Exception as e {
                        addLog("❌ Error in Step 3: " + (e.toString()));
                    }
                    
                } except Exception as e {
                    addLog("❌ Error in Step 2: " + (e.toString()));
                }
                
            } except Exception as e {
                addLog("❌ Error in Step 1: " + (e.toString()));
            }
        }

        let codeText = "# Nested try/except\ntry {\n    # Step 1\n    try {\n        # Step 2\n        try {\n            # Step 3\n        } except { ... }\n    } except { ... }\n} except { ... }";

        def renderLog(log: str, index: int) -> any {
            return <li key={index}>{log}</li>;
        }

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>7. Nested Try/Except - Multi-Step Process</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <button style={styles["button"]} onClick={lambda: processSteps(0)}>
                    Run All (Success)
                </button>
                <button style={styles["dangerButton"]} onClick={lambda: processSteps(1)}>
                    Fail at Step 1
                </button>
                <button style={styles["dangerButton"]} onClick={lambda: processSteps(2)}>
                    Fail at Step 2
                </button>
                <button style={styles["dangerButton"]} onClick={lambda: processSteps(3)}>
                    Fail at Step 3
                </button>
                
                <div style={styles["result"]}>
                    <strong>Process Log:</strong>
                    <ul>{logs.map(renderLog)}</ul>
                </div>
            </div>
        );
    }

    # ============================================
    # Example 8: RE-RAISING EXCEPTIONS
    # Catch, log, and re-throw
    # ============================================
    def Example8_ReRaiseException() -> any {
        let [logs, setLogs] = useState([]);
        let [finalError, setFinalError] = useState("");

        def addLog(msg: str) -> None {
            setLogs(logs.concat([msg]));
        }

        def innerFunction() -> None {
            raise Exception("Something broke in inner function!");
        }

        def outerFunction() -> None {
            try {
                addLog("📝 Calling inner function...");
                innerFunction();
            } except Exception as e {
                addLog("⚠️ Caught error, logging and re-raising...");
                addLog("📋 Logged error: " + (e.toString()));
                raise e;  # Re-raise the exception
            }
        }

        def mainFunction() -> None {
            setLogs([]);
            setFinalError("");
            
            try {
                addLog("🚀 Starting main function...");
                outerFunction();
                addLog("✅ Completed successfully");
            } except Exception as e {
                addLog("❌ Final error handler caught: " + (e.toString()));
                setFinalError((e.toString()));
            }
        }

        let codeText = "# Re-raising exceptions\ntry {\n    innerFunction();\n} except Exception as e {\n    console.log('Logged:', e);\n    raise e;  # Re-raise\n}";

        def renderLog(log: str, index: int) -> any {
            return <li key={index}>{log}</li>;
        }

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>8. Re-Raising Exceptions</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <button style={styles["dangerButton"]} onClick={mainFunction}>
                    Run (Will Fail & Re-raise)
                </button>
                
                <div style={styles["result"]}>
                    <strong>Execution Log:</strong>
                    <ul>{logs.map(renderLog)}</ul>
                </div>
                
                {finalError and (
                    <div style={styles["error"]}>
                        <strong>Final Error:</strong> {finalError}
                    </div>
                )}
            </div>
        );
    }

    # ============================================
    # Example 9: CUSTOM ERROR MESSAGES
    # Creating descriptive errors
    # ============================================
    def Example9_CustomErrorMessages() -> any {
        let [result, setResult] = useState("");
        let [error, setError] = useState("");

        def withdraw(balance: int, amount: int) -> None {
            setError("");
            setResult("");
            
            try {
                if amount <= 0 {
                    raise Exception("Invalid amount: Withdrawal amount must be positive. You entered: " + (amount.toString()));
                }
                
                if amount > balance {
                    raise Exception("Insufficient funds: Tried to withdraw $" + (amount.toString()) + " but balance is only $" + String(balance));
                }
                
                if amount > 1000 {
                    raise Exception("Limit exceeded: Maximum single withdrawal is $1000. You tried: $" + (amount.toString()));
                }
                
                let newBalance = balance - amount;
                setResult("✅ Withdrew $" + (amount.toString()) + ". New balance: $" + (newBalance.toString()));
                
            } except Exception as e {
                setError((e.toString()));
            }
        }

        let balance = 500;

        let codeText = "# Custom error messages\nif amount <= 0 {\n    raise Exception('Invalid: Amount must be positive!');\n}\nif amount > balance {\n    raise Exception('Insufficient funds: $' + amount.toString());\n}";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>9. Custom Error Messages - Bank Withdrawal</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <p>Current Balance: <strong>${balance}</strong></p>
                
                <button style={styles["button"]} onClick={lambda: withdraw(balance, 100)}>
                    Withdraw $100
                </button>
                <button style={styles["button"]} onClick={lambda: withdraw(balance, 400)}>
                    Withdraw $400
                </button>
                <button style={styles["dangerButton"]} onClick={lambda: withdraw(balance, 600)}>
                    Withdraw $600 (Insufficient!)
                </button>
                <button style={styles["dangerButton"]} onClick={lambda: withdraw(balance, -50)}>
                    Withdraw -$50 (Invalid!)
                </button>
                <button style={styles["dangerButton"]} onClick={lambda: withdraw(balance, 1500)}>
                    Withdraw $1500 (Over limit!)
                </button>
                
                {result and <div style={styles["success"]}>{result}</div>}
                {error and <div style={styles["error"]}>❌ {error}</div>}
            </div>
        );
    }

    # ============================================
    # Example 10: SAFE FUNCTION WRAPPER
    # Wrapping risky operations
    # ============================================
    def Example10_SafeWrapper() -> any {
        let [result, setResult] = useState("");
        let [error, setError] = useState("");

        # Safe wrapper function
        def safeExecute(operation: str, func: any) -> None {
            setError("");
            setResult("");
            
            try {
                let value = func();
                setResult("✅ " + operation + " succeeded: " + value.toString());
            } except Exception as e {
                setError("❌ " + operation + " failed: " + e.toString());
            }
        }

        # Different operations to test
        def safeDivide() -> int {
            return 10 / 2;
        }

        def unsafeDivide() -> int {
            return 10 / 0;
        }

        def safeParseInt() -> int {
            return parseInt("42");
        }

        def unsafeParseInt() -> int {
            let value = parseInt("hello");
            if isNaN(value) {
                raise Exception("Cannot parse 'hello' as integer");
            }
            return value;
        }

        let codeText = "# Safe execution wrapper\ndef safeExecute(name: str, func: any) -> None {\n    try {\n        let value = func();\n        setResult(name + ' succeeded!');\n    } except Exception as e {\n        setError(name + ' failed: ' + e.toString());\n    }\n}";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>10. Safe Function Wrapper</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <button style={styles["button"]} onClick={lambda: safeExecute("Safe Division", safeDivide)}>
                    10 / 2 (Safe)
                </button>
                <button style={styles["dangerButton"]} onClick={lambda: safeExecute("Unsafe Division", unsafeDivide)}>
                    10 / 0 (Error!)
                </button>
                <button style={styles["button"]} onClick={lambda: safeExecute("Parse '42'", safeParseInt)}>
                    Parse 42 (Safe)
                </button>
                <button style={styles["dangerButton"]} onClick={lambda: safeExecute("Parse 'hello'", unsafeParseInt)}>
                    Parse hello (Error!)
                </button>
                
                {result and <div style={styles["success"]}>{result}</div>}
                {error and <div style={styles["error"]}>{error}</div>}
            </div>
        );
    }

    # ============================================
    # Example 11: ERROR RECOVERY
    # Using default values on error
    # ============================================
    def Example11_ErrorRecovery() -> any {
        let [results, setResults] = useState([]);

        def parseWithDefault(value: str, defaultVal: int) -> int {
            try {
                let parsed = parseInt(value);
                if isNaN(parsed) {
                    raise Exception("Not a number");
                }
                return parsed;
            } except Exception as e {
                return defaultVal;  # Return default on error
            }
        }

        def testParsing() -> None {
            let testCases = ["42", "hello", "100", "abc", "-5", ""];
            let defaultValue = 0;
            
            let parsedResults = [];
            for testCase in testCases {
                let result = parseWithDefault(testCase, defaultValue);
                parsedResults = parsedResults.concat([{
                    "input": testCase,
                    "output": result,
                    "usedDefault": (testCase == "hello" or testCase == "abc" or testCase == "")
                }]);
            }
            setResults(parsedResults);
        }

        let codeText = "# Error recovery with default values\ndef parseWithDefault(value: str, default: int) -> int {\n    try {\n        return parseInt(value);\n    } except {\n        return default;  # Use default on error\n    }\n}";

        def renderResult(item: dict, index: int) -> any {
            return (
                <tr key={index}>
                    <td style={{ "padding": "8px", "border": "1px solid #ddd" }}>
                        {("'" + item["input"] + "'") if item["input"] else "(empty)"}
                    </td>
                    <td style={{ "padding": "8px", "border": "1px solid #ddd" }}>{item["output"]}</td>
                    <td style={{ "padding": "8px", "border": "1px solid #ddd" }}>
                        {(("⚠️ Used default") if item["usedDefault"] else ("✅ Parsed"))}
                    </td>
                </tr>
            );
        }

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>11. Error Recovery - Default Values</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <button style={styles["button"]} onClick={testParsing}>
                    Test Parsing Multiple Values
                </button>
                
                {results.length > 0 and (
                    <table style={{ "width": "100%", "borderCollapse": "collapse", "marginTop": "15px" }}>
                        <thead>
                            <tr style={{ "backgroundColor": "#f0f0f0" }}>
                                <th style={{ "padding": "8px", "border": "1px solid #ddd" }}>Input</th>
                                <th style={{ "padding": "8px", "border": "1px solid #ddd" }}>Output</th>
                                <th style={{ "padding": "8px", "border": "1px solid #ddd" }}>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            {results.map(renderResult)}
                        </tbody>
                    </table>
                )}
            </div>
        );
    }

    # ============================================
    # Example 12: ASYNC ERROR HANDLING (Simulated)
    # Handling errors in async-like operations
    # ============================================
    def Example12_AsyncErrorHandling() -> any {
        let [loading, setLoading] = useState(False);
        let [data, setData] = useState(None);
        let [error, setError] = useState("");

        def simulateFetch(shouldFail: bool) -> None {
            setLoading(True);
            setData(None);
            setError("");
            
            # Simulate async with setTimeout
            setTimeout(lambda -> None {
                try {
                    if shouldFail {
                        raise Exception("Network error: Failed to fetch data");
                    }
                    setData({ "message": "Data loaded successfully!", "items": ["Item 1", "Item 2", "Item 3"] });
                } except Exception as e {
                    setError(e.toString());
                } finally {
                    setLoading(False);
                }
            }, 1000);
        }

        let codeText = "# Async-like error handling\ntry {\n    if shouldFail {\n        raise Exception('Network error!');\n    }\n    setData(response);\n} except Exception as e {\n    setError(e.toString());\n} finally {\n    setLoading(False);\n}";

        def renderItem(item: str, index: int) -> any {
            return <li key={index}>{item}</li>;
        }

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>12. Async-Like Error Handling</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <button 
                    style={styles["button"]} 
                    onClick={lambda: simulateFetch(False)}
                    disabled={loading}
                >
                    {("Loading...") if loading else ("Fetch Data (Success)")}
                </button>
                <button 
                    style={styles["dangerButton"]} 
                    onClick={lambda: simulateFetch(True)}
                    disabled={loading}
                >
                    {("Loading...") if loading else ("Fetch Data (Will Fail)")}
                </button>
                
                {loading and <div style={styles["result"]}>⏳ Loading...</div>}
                {data and (
                    <div style={styles["success"]}>
                        <p>✅ {data["message"]}</p>
                        <ul>{data["items"].map(renderItem)}</ul>
                    </div>
                )}
                {error and <div style={styles["error"]}>❌ {error}</div>}
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
                    🛡️ Exception Handling in JAC-Lang (Onelang)
                </h1>
                <p style={{ "textAlign": "center", "color": "#666", "marginBottom": "30px" }}>
                    React uses try/catch - JAC uses try/except (Python-style)
                </p>
                
                <div style={{ "backgroundColor": "#e7f3ff", "padding": "15px", "borderRadius": "8px", "marginBottom": "20px" }}>
                    <h4>🔑 Key Syntax Difference:</h4>
                    <p><strong>React:</strong> try {"{ }"} catch(e) {"{ }"} finally {"{ }"}</p>
                    <p><strong>JAC:</strong> try {"{ }"} except Exception as e {"{ }"} finally {"{ }"}</p>
                </div>

                <Example1_BasicTryExcept />
                <Example2_TryExceptFinally />
                <Example3_JsonParseError />
                <Example4_ArrayIndexError />
                <Example5_ObjectKeyError />
                <Example6_InputValidation />
                <Example7_NestedTryExcept />
                <Example8_ReRaiseException />
                <Example9_CustomErrorMessages />
                <Example10_SafeWrapper />
                <Example11_ErrorRecovery />
                <Example12_AsyncErrorHandling />
            </div>
        );
    }
}

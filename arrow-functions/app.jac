
# ============================================
# LAMBDA FUNCTIONS IN JAC-LANG (ONELANG)
# Equivalent to Arrow Functions in React/JavaScript
# ============================================

# Import React hooks
cl import from react {useState, useEffect, useCallback, useMemo}

cl {
    # Styles for consistent UI
    let styles = {
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
            "padding": "10px",
            "backgroundColor": "#e8f5e9",
            "borderRadius": "5px",
            "marginTop": "10px"
        }
    };

    # ============================================
    # 1. BASIC LAMBDA - No Parameters
    # React: () => { ... }
    # JAC: lambda -> ReturnType { ... } OR lambda: expression
    # ============================================
    def Example1_NoParams() -> any {
        let [message, setMessage] = useState("Click the button!");

        # Lambda with no parameters and no return (void)
        # Syntax: lambda -> None { statements; }
        let showMessage = lambda -> None {
            setMessage("Hello from lambda function!");
        };

        # Code example content
        let codeText = "# JAC: lambda -> None { setMessage('Hello!'); }\n# Short: lambda: setMessage('Clicked!')\n# React: () => setMessage('Hello')";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>1. No Parameters Lambda</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                <button style={styles["button"]} onClick={showMessage}>
                    Call Function
                </button>
                <button style={styles["button"]} onClick={lambda: setMessage("Inline lambda!")}>
                    Inline Lambda
                </button>
                <div style={styles["result"]}>Result: {message}</div>
            </div>
        );
    }

    # ============================================
    # 2. LAMBDA - Single Parameter
    # React: (e) => { ... } or e => expr
    # JAC: lambda param: Type -> ReturnType { ... }
    # ============================================
    def Example2_SingleParam() -> any {
        let [doubled, setDoubled] = useState(0);
        let [inputValue, setInputValue] = useState("");

        # Lambda with single parameter
        # Syntax: lambda param: Type -> ReturnType { statements; }
        let doubleNumber = lambda n: int -> None {
            setDoubled(n * 2);
        };

        # Event handler with single parameter
        let handleChange = lambda e: any -> None {
            setInputValue(e.target.value);
        };

        # Code example
        let codeText = "# JAC: lambda n: int -> None { setDoubled(n * 2); }\n# Event: lambda e: any -> None { setInputValue(e.target.value); }\n# React: (n) => setDoubled(n * 2)";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>2. Single Parameter Lambda</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                <button style={styles["button"]} onClick={lambda: doubleNumber(5)}>
                    Double 5
                </button>
                <button style={styles["button"]} onClick={lambda: doubleNumber(10)}>
                    Double 10
                </button>
                <div style={styles["result"]}>Doubled: {doubled}</div>
                <input
                    type="text"
                    placeholder="Type something..."
                    value={inputValue}
                    onChange={handleChange}
                    style={{ "padding": "8px", "marginTop": "10px" }}
                />
                <div style={styles["result"]}>Input: {inputValue}</div>
            </div>
        );
    }

    # ============================================
    # 2.5 COMPLEX INLINE ONCLICK with Lambda
    # React: onClick={() => { multiple; statements; }}
    # JAC: onClick={lambda -> None { multiple; statements; }}
    # ============================================
    def Example2_5_ComplexInlineOnClick() -> any {
        let [count, setCount] = useState(0);
        let [log, setLog] = useState("");
        let [isValid, setIsValid] = useState(True);
        let [formData, setFormData] = useState({ "name": "", "submitted": False });

        # Code example
        let codeText = "# Simple: onClick={lambda: fn()}\n# Complex: onClick={lambda -> None { a(); b(); c(); }}\n# With event: onClick={lambda e: any -> None { e.preventDefault(); fn(); }}";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>2.5 Complex Inline onClick with Lambda</h3>
                <pre style={styles["code"]}>{codeText}</pre>

                <h4>Multiple Actions in One Click:</h4>
                <button 
                    style={styles["button"]} 
                    onClick={lambda -> None {
                        setCount(count + 1);
                        setLog("Clicked at: " + Date().toLocaleTimeString());
                        console.log("Button clicked!");
                    }}
                >
                    Multi-Action ({count})
                </button>
                <div style={styles["result"]}>Log: {log}</div>

                <h4>Conditional Logic in onClick:</h4>
                <div style={{ "marginBottom": "10px" }}>
                    <label>
                        <input 
                            type="checkbox" 
                            checked={isValid}
                            onChange={lambda -> None { setIsValid(not isValid); }}
                        />
                        {" "}Is Valid: {("Yes") if isValid else ("No")}
                    </label>
                </div>
                <button 
                    style={styles["button"]} 
                    onClick={lambda -> None {
                        if isValid {
                            setLog("✅ Success! Form submitted.");
                            setCount(count + 1);
                        } else {
                            setLog("❌ Error! Please check the checkbox first.");
                        }
                    }}
                >
                    Submit (with validation)
                </button>

                <h4>Prevent Default + Action:</h4>
                <form onSubmit={lambda e: any -> None {
                    e.preventDefault();
                    setFormData({ "name": formData["name"], "submitted": True });
                    setLog("Form submitted with: " + formData["name"]);
                }}>
                    <input
                        type="text"
                        placeholder="Enter name..."
                        value={formData["name"]}
                        onChange={lambda e: any -> None {
                            setFormData({ "name": e.target.value, "submitted": False });
                        }}
                        style={{ "padding": "8px", "marginRight": "10px" }}
                    />
                    <button type="submit" style={styles["button"]}>
                        Submit Form
                    </button>
                </form>
                <div style={styles["result"]}>
                    {formData["submitted"] and <p>✅ Submitted: {formData["name"]}</p>}
                </div>

                <h4>Toggle with Complex Logic:</h4>
                <button 
                    style={{
                        "padding": "10px 20px",
                        "backgroundColor": ("#28a745") if (count % 2 == 0) else ("#dc3545"),
                        "color": "white",
                        "border": "none",
                        "borderRadius": "5px",
                        "cursor": "pointer"
                    }}
                    onClick={lambda -> None {
                        let newCount = count + 1;
                        setCount(newCount);
                        if newCount % 5 == 0 {
                            setLog("🎉 Milestone! Count is " + (newCount.toString()));
                        } elif newCount % 2 == 0 {
                            setLog("Even: " + (newCount.toString()));
                        } else {
                            setLog("Odd: " + (newCount.toString()));
                        }
                    }}
                >
                    Toggle Counter ({count})
                </button>
                <div style={styles["result"]}>{log}</div>
            </div>
        );
    }

    # ============================================
    # 3. LAMBDA - Multiple Parameters
    # React: (a, b, op) => { ... }
    # JAC: lambda a: Type, b: Type -> ReturnType { ... }
    # ============================================
    def Example3_MultipleParams() -> any {
        let [result, setResult] = useState(0);

        # Lambda with multiple parameters
        let calculate = lambda a: int, b: int, operation: str -> None {
            if operation == "add" {
                setResult(a + b);
            } elif operation == "multiply" {
                setResult(a * b);
            } elif operation == "subtract" {
                setResult(a - b);
            } else {
                setResult(0);
            }
        };

        # Code example
        let codeText = "# JAC: lambda a: int, b: int, op: str -> None { ... }\n# Usage: onClick={lambda: calculate(5, 3, 'add')}\n# React: (a, b, op) => { if (op === 'add') setResult(a + b); }";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>3. Multiple Parameters Lambda</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                <button style={styles["button"]} onClick={lambda: calculate(5, 3, "add")}>
                    5 + 3
                </button>
                <button style={styles["button"]} onClick={lambda: calculate(5, 3, "multiply")}>
                    5 × 3
                </button>
                <button style={styles["button"]} onClick={lambda: calculate(10, 4, "subtract")}>
                    10 - 4
                </button>
                <div style={styles["result"]}>Result: {result}</div>
            </div>
        );
    }

    # ============================================
    # 4. LAMBDA - With Return Value (Implicit/Explicit)
    # React: (n) => n * 2 (implicit) or (n) => { return n * 2; }
    # JAC: lambda n: int -> int { return n * 2; }
    # ============================================
    def Example4_ReturnValue() -> any {
        let numbers = [1, 2, 3, 4, 5];

        # Lambda with return value for map
        # Syntax: lambda param: Type -> ReturnType { return expr; }
        def doubleItem(n: any, index: int) -> any {
            return n * 2;
        }

        def renderItem(n: any, index: int) -> any {
            return <li key={index}>{n}</li>;
        }

        def renderCard(n: any, index: int) -> any {
            return (
                <div key={index} style={{ "padding": "5px", "margin": "5px", "backgroundColor": "#ddd", "display": "inline-block" }}>
                    Card {n}
                </div>
            );
        }

        let doubled = numbers.map(doubleItem);
        let listItems = numbers.map(renderItem);
        let cards = numbers.map(renderCard);

        # Code example
        let codeText = "# JAC: def doubleItem(n: int, index: int) -> any { return n * 2; }\n# let doubled = numbers.map(doubleItem);\n# React: numbers.map(n => n * 2)";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>4. Lambda with Return Value</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                <div style={styles["result"]}>
                    <strong>Original:</strong> [{numbers.join(", ")}]
                    <br />
                    <strong>Doubled:</strong> [{doubled.join(", ")}]
                </div>
                <ul>{listItems}</ul>
                <div>{cards}</div>
            </div>
        );
    }

    # ============================================
    # 5. LAMBDA in useEffect
    # React: useEffect(() => { ... }, [deps])
    # JAC: useEffect(lambda -> None { ... }, [deps])
    # ============================================
    def Example5_UseEffect() -> any {
        let [count, setCount] = useState(0);
        let [logs, setLogs] = useState([]);

        # useEffect with lambda
        useEffect(lambda -> None {
            console.log("Effect ran! Count is:", count);
            # Note: updating logs inside effect would cause infinite loop
            # This is just for demonstration
        }, [count]);

        # useEffect on mount (empty deps)
        useEffect(lambda -> None {
            console.log("Component mounted!");
        }, []);

        def renderLog(log: str, index: int) -> any {
            return <li key={index}>{log}</li>;
        }

        # Code example
        let codeText = "# JAC: useEffect(lambda -> None { console.log('Effect!'); }, [count]);\n# On mount: useEffect(lambda -> None { ... }, []);\n# React: useEffect(() => { ... }, [count])";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>5. Lambda in useEffect</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                <button style={styles["button"]} onClick={lambda: setCount(count + 1)}>
                    Increment Count ({count})
                </button>
                <div style={styles["result"]}>
                    <strong>Check browser console for effect logs!</strong>
                    <p>Count: {count}</p>
                </div>
            </div>
        );
    }

    # ============================================
    # 6. LAMBDA - Event Handlers with Parameters
    # React: onClick={() => handleSelect(id, name)}
    # JAC: onClick={lambda: handleSelect(id, name)}
    # ============================================
    def Example6_EventHandlers() -> any {
        let [selected, setSelected] = useState(None);
        let [inputValues, setInputValues] = useState({ "name": "", "email": "" });

        # Handler that needs extra parameters
        let handleSelect = lambda id: int, name: str -> None {
            setSelected({ "id": id, "name": name });
        };

        # Handler for name field
        let handleNameChange = lambda e: any -> None {
            setInputValues({ "name": e.target.value, "email": inputValues["email"] });
        };

        # Handler for email field
        let handleEmailChange = lambda e: any -> None {
            setInputValues({ "name": inputValues["name"], "email": e.target.value });
        };

        let items = [
            { "id": 1, "name": "Apple" },
            { "id": 2, "name": "Banana" },
            { "id": 3, "name": "Cherry" }
        ];

        def renderButton(item: dict, index: int) -> any {
            let isSelected = selected and selected["id"] == item["id"];
            return (
                <button
                    key={item["id"]}
                    style={{
                        "padding": "10px 20px",
                        "marginRight": "10px",
                        "marginBottom": "10px",
                        "backgroundColor": ("#28a745") if isSelected else ("#007bff"),
                        "color": "white",
                        "border": "none",
                        "borderRadius": "5px",
                        "cursor": "pointer"
                    }}
                    onClick={lambda: handleSelect(item["id"], item["name"])}
                >
                    {item["name"]}
                </button>
            );
        }

        # Code example
        let codeText = "# JAC: lambda id: int, name: str -> None { setSelected({...}); }\n# onClick={lambda: handleSelect(1, 'Apple')}\n# React: onClick={() => handleSelect(1, 'Apple')}";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>6. Event Handlers with Parameters</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                <div>
                    {items.map(renderButton)}
                </div>
                <div style={styles["result"]}>
                    Selected: {(selected["name"] + " (ID: " + (selected["id"]) + ")").toString() if selected else "None"}
                </div>
                <div style={{ "marginTop": "15px" }}>
                    <input
                        placeholder="Name"
                        value={inputValues["name"]}
                        onChange={handleNameChange}
                        style={{ "padding": "8px", "marginRight": "10px" }}
                    />
                    <input
                        placeholder="Email"
                        value={inputValues["email"]}
                        onChange={handleEmailChange}
                        style={{ "padding": "8px" }}
                    />
                    <div style={styles["result"]}>
                        Name: {inputValues["name"]} | Email: {inputValues["email"]}
                    </div>
                </div>
            </div>
        );
    }

    # ============================================
    # 7. LAMBDA - Array Methods (map, filter, find)
    # React: arr.map(item => item.name)
    # JAC: arr.map(helperFunction)
    # ============================================
    def Example7_ArrayMethods() -> any {
        let users = [
            { "id": 1, "name": "Alice", "age": 25, "active": True },
            { "id": 2, "name": "Bob", "age": 30, "active": False },
            { "id": 3, "name": "Charlie", "age": 35, "active": True },
            { "id": 4, "name": "Diana", "age": 28, "active": True }
        ];

        # Helper functions for array operations
        def getName(user: dict, index: int) -> any {
            return user["name"];
        }

        def isActive(user: dict, index: int) -> any {
            return user["active"];
        }

        def getAge(user: dict, index: int) -> any {
            return user["age"];
        }

        # Using array methods with helper functions
        let names = users.map(getName);
        let activeUsers = users.filter(isActive);
        let activeNames = activeUsers.map(getName);

        # Calculate total age manually (reduce not always available)
        let totalAge = 0;
        for user in users {
            totalAge = totalAge + user["age"];
        }

        # Code example
        let codeText = "# JAC: def getName(user: dict, index: int) -> str { return user['name']; }\n# let names = users.map(getName); let activeUsers = users.filter(isActive);\n# React: users.map(u => u.name); users.filter(u => u.active)";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>7. Array Methods with Lambdas/Functions</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                <div style={styles["result"]}>
                    <p><strong>Names (map):</strong> {names.join(", ")}</p>
                    <p><strong>Active Users (filter):</strong> {activeNames.join(", ")}</p>
                    <p><strong>Total Age:</strong> {totalAge}</p>
                </div>
            </div>
        );
    }

    # ============================================
    # 8. LAMBDA - useCallback Pattern
    # React: useCallback(() => { ... }, [deps])
    # JAC: useCallback(lambda -> Type { ... }, [deps])
    # ============================================
    def Example8_UseCallback() -> any {
        let [count, setCount] = useState(0);
        let [multiplier, setMultiplier] = useState(2);

        # useCallback with lambda
        let increment = useCallback(
            lambda -> None { setCount(count + 1); },
            [count]
        );

        # useMemo for computed values
        let expensiveCalculation = useMemo(
            lambda -> int {
                console.log("Calculating...");
                return count * multiplier * 100;
            },
            [count, multiplier]
        );

        # Code example
        let codeText = "# JAC: useCallback(lambda -> None { ... }, [deps]);\n# useMemo(lambda -> int { return val; }, [deps]);\n# React: useCallback(() => { ... }, []); useMemo(() => val, [])";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>8. useCallback & useMemo with Lambdas</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                <button style={styles["button"]} onClick={increment}>
                    Increment ({count})
                </button>
                <button style={styles["button"]} onClick={lambda: setMultiplier(multiplier + 1)}>
                    Increase Multiplier ({multiplier})
                </button>
                <div style={styles["result"]}>
                    <p>Count: {count}</p>
                    <p>Multiplier: {multiplier}</p>
                    <p>Expensive Calculation: {expensiveCalculation}</p>
                </div>
            </div>
        );
    }

    # ============================================
    # 9. LAMBDA - Async Functions
    # React: async () => { await ... }
    # JAC: async def funcName() { await ... }
    # ============================================
    def Example9_Async() -> any {
        let [data, setData] = useState(None);
        let [loading, setLoading] = useState(False);

        # Async function (use 'async def' instead of lambda for async)
        async def fetchData() {
            setLoading(True);
            try {
                # Simulated delay using setTimeout
                await setTimeout(lambda -> None {}, 1000);
                setData({ "message": "Data fetched successfully!", "timestamp": Date().toLocaleTimeString() });
            } finally {
                setLoading(False);
            }
        }

        # Code example
        let codeText = "# JAC: async def fetchData() { data = await fetch(...); }\n# React: const fetchData = async () => { await fetch(...); }";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>9. Async Functions</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                <button 
                    style={styles["button"]} 
                    onClick={lambda: fetchData()}
                    disabled={loading}
                >
                    {("Loading...") if loading else ("Fetch Data")}
                </button>
                <div style={styles["result"]}>
                    {loading and <p>⏳ Loading...</p>}
                    {data and (
                        <p>✅ {data["message"]} (at {data["timestamp"]})</p>
                    )}
                </div>
            </div>
        );
    }

    # ============================================
    # 10. LAMBDA - State Updates with Previous State
    # React: setState(prev => prev + 1)
    # JAC: setState(count + 1) or use callback pattern
    # ============================================
    def Example10_StateUpdates() -> any {
        let [items, setItems] = useState([
            { "id": 1, "text": "Item 1", "done": False },
            { "id": 2, "text": "Item 2", "done": True }
        ]);

        # Toggle item done status
        def toggleItem(id: any) -> None {
            def updateItem(item: dict, index: int) -> dict {
                if item["id"] == id {
                    return { "id": item["id"], "text": item["text"], "done": not item["done"] };
                }
                return item;
            }
            setItems(items.map(updateItem));
        }

        # Add new item
        def addItem() -> None {
            
            let newItem = { "id": Date.now(), "text": "Item " + (items.length + 1), "done": False };
            let newItems = items.concat([newItem]);
            setItems(newItems);
        }

        def renderItem(item: dict, index: int) -> any {
            return (
                <div
                    key={item["id"]}
                    onClick={lambda: toggleItem(item["id"])}
                    style={{
                        "padding": "8px",
                        "marginBottom": "5px",
                        "backgroundColor": ("#d4edda") if item["done"] else ("#fff3cd"),
                        "cursor": "pointer",
                        "borderRadius": "4px"
                    }}
                >
                    {("✅") if item["done"] else ("⬜")} {item["text"]}
                </div>
            );
        }

        # Code example
        let codeText = "# JAC: setItems(items.concat([newItem])); items.map(updateItem)\n# def updateItem(item: dict) { return {...}; }\n# React: setItems([...items, newItem]); setItems(prev => prev.map(...))";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>10. State Updates & Object Manipulation</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                <button style={styles["button"]} onClick={addItem}>
                    Add Item
                </button>
                <div style={styles["result"]}>
                    {items.map(renderItem)}
                </div>
            </div>
        );
    }

    # ============================================
    # 11. INLINE LAMBDA in JSX - map, filter, some directly in {}
    # React: {items.map(item => <div>{item.name}</div>)}
    # JAC: {items.map(lambda item: any -> any { return <div>...</div>; })}
    # ============================================
    def Example11_InlineLambdaInJSX() -> any {
        let [selected, setSelected] = useState(None);

        let items = [
            { "id": 1, "name": "Apple", "price": 1.5, "inStock": True },
            { "id": 2, "name": "Banana", "price": 0.75, "inStock": True },
            { "id": 3, "name": "Cherry", "price": 3.0, "inStock": False },
            { "id": 4, "name": "Date", "price": 2.5, "inStock": True },
            { "id": 5, "name": "Elderberry", "price": 4.0, "inStock": False }
        ];

        # Handler for selection
        let handleSelect = lambda id: any, name: str -> None {
            setSelected({ "id": id, "name": name });
        };

        # Code example
        let codeText = "# Inline .map() in JSX:\n{items.map(lambda item: any -> any { return <button>...</button>; })}\n\n# Inline .filter().map() chain:\n{items.filter(...).map(...)}";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>11. Inline Lambda in JSX (map, filter, some)</h3>
                <pre style={styles["code"]}>{codeText}</pre>

                <h4>Inline .map() - Render buttons directly:</h4>
                <div>
                    {items.map(lambda item: any, index:int -> any {
                        let isSelected = selected and selected["id"] == item["id"];
                        return (
                            <button
                                key={item["id"]+index}
                                style={{
                                    "padding": "10px 20px",
                                    "marginRight": "10px",
                                    "marginBottom": "10px",
                                    "backgroundColor": ("#28a745") if isSelected else ("#007bff"),
                                    "color": "white",
                                    "border": "none",
                                    "borderRadius": "5px",
                                    "cursor": "pointer"
                                }}
                                onClick={lambda: handleSelect(item["id"], item["name"])}
                            >
                                {item["name"]} - ${item["price"]}
                            </button>
                        );
                    })}
                </div>
                <div style={styles["result"]}>
                    Selected: {(selected["name"]) if selected else "None"}
                </div>

                <h4>Inline .filter().map() - Only show items in stock:</h4>
                <div>
                    {items.filter(lambda item: any -> any {
                        return item["inStock"];
                    }).map(lambda item: any -> any {
                        return (
                            <span
                                key={item["id"]}
                                style={{
                                    "display": "inline-block",
                                    "padding": "5px 10px",
                                    "margin": "5px",
                                    "backgroundColor": "#d4edda",
                                    "borderRadius": "4px"
                                }}
                            >
                                ✅ {item["name"]}
                            </span>
                        );
                    })}
                </div>

                <h4>Inline .filter().map() - Out of stock items:</h4>
                <div>
                    {items.filter(lambda item: any -> any {
                        return not item["inStock"];
                    }).map(lambda item: any -> any {
                        return (
                            <span
                                key={item["id"]}
                                style={{
                                    "display": "inline-block",
                                    "padding": "5px 10px",
                                    "margin": "5px",
                                    "backgroundColor": "#f8d7da",
                                    "borderRadius": "4px"
                                }}
                            >
                                ❌ {item["name"]}
                            </span>
                        );
                    })}
                </div>

                <h4>Using .some() for conditional rendering:</h4>
                <div style={styles["result"]}>
                    {items.some(lambda item: any -> any { return not item["inStock"]; }) and (
                        <p style={{ "color": "#dc3545" }}>⚠️ Some items are out of stock!</p>
                    )}
                    {items.some(lambda item: any -> any { return item["price"] > 3; }) and (
                        <p style={{ "color": "#fd7e14" }}>💰 Premium items available (over $3)</p>
                    )}
                    {items.every(lambda item: any -> any { return item["price"] < 10; }) and (
                        <p style={{ "color": "#28a745" }}>✅ All items are under $10</p>
                    )}
                </div>

                <h4>Inline .map() with index:</h4>
                <ol>
                    {items.map(lambda item: any, index: int -> any {
                        return (
                            <li key={item["id"]}>
                                #{index + 1}: {item["name"]} 
                                {(" (In Stock)") if item["inStock"] else (" (Out of Stock)")}
                            </li>
                        );
                    })}
                </ol>
            </div>
        );
    }

    # ============================================
    # MAIN APP COMPONENT
    # ============================================
    def app() -> any {
        return (
            <div style={{
                "fontFamily": "Arial, sans-serif",
                "maxWidth": "900px",
                "margin": "0 auto",
                "padding": "20px"
            }}>
                <h1 style={{ "textAlign": "center", "color": "#333" }}>
                    🎯 Lambda Functions in JAC-Lang (Onelang)
                </h1>
                <p style={{ "textAlign": "center", "color": "#666", "marginBottom": "30px" }}>
                    Equivalent to Arrow Functions in React/JavaScript - Compare with app.js
                </p>

                <Example1_NoParams />
                <Example2_SingleParam />
                <Example2_5_ComplexInlineOnClick />
                <Example3_MultipleParams />
                <Example4_ReturnValue />
                <Example5_UseEffect />
                <Example6_EventHandlers />
                <Example7_ArrayMethods />
                <Example8_UseCallback />
                <Example9_Async />
                <Example10_StateUpdates />
                <Example11_InlineLambdaInJSX />
            </div>
        );
    }
}


<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Edit Schedule</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

    <style>
        :root {
            --primary-gradient: linear-gradient(120deg, #9333ea 0%, #4c1d95 50%, #000000 100%);
            --glass-gradient: linear-gradient(120deg, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0.05) 100%);
            --button-gradient: linear-gradient(120deg, #8b5cf6 0%, #6d28d9 100%);
        }
        
        body {
            background: var(--primary-gradient);
            min-height: 100vh;
            color: #fff;
            font-family: 'Segoe UI', system-ui, sans-serif;
            position: relative;
            overflow-x: hidden;
        }

        /* Animated Bubbles */
        .bubbles {
            position: fixed;
            width: 100%;
            height: 100%;
            z-index: 0;
            overflow: hidden;
            top: 0;
            left: 0;
        }

        .bubble {
            position: absolute;
            bottom: -100px;
            width: 40px;
            height: 40px;
            background: rgba(79, 70, 229, 0.1);
            border-radius: 50%;
            opacity: 0.5;
            animation: rise 10s infinite ease-in;
        }

        .bubble:nth-child(1) {
            width: 40px;
            height: 40px;
            left: 10%;
            animation-duration: 8s;
        }

        .bubble:nth-child(2) {
            width: 20px;
            height: 20px;
            left: 20%;
            animation-duration: 5s;
            animation-delay: 1s;
        }

        .bubble:nth-child(3) {
            width: 50px;
            height: 50px;
            left: 35%;
            animation-duration: 7s;
            animation-delay: 2s;
        }

        @keyframes rise {
            0% {
                bottom: -100px;
                transform: translateX(0);
            }
            50% {
                transform: translateX(100px);
            }
            100% {
                bottom: 1080px;
                transform: translateX(-200px);
            }
        }

        .container {
            position: relative;
            padding: 2rem;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            margin-top: 2rem;
            margin-bottom: 2rem;
            border: 1px solid rgba(255, 255, 255, 0.1);
            z-index: 1;
        }

        h1 {
            font-weight: bold;
            text-align: center;
            margin-bottom: 2rem;
            font-size: 2.5rem;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #fff;
            text-shadow: 0 0 10px rgba(147, 51, 234, 0.5);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-control {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            color: #fff;
            padding: 0.75rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.15);
            border-color: rgba(147, 51, 234, 0.5);
            box-shadow: 0 0 0 0.2rem rgba(147, 51, 234, 0.25);
            color: #fff;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }

        label {
            color: #fff;
            font-weight: 500;
            margin-bottom: 0.5rem;
            font-size: 1.1rem;
            letter-spacing: 0.5px;
        }

        .btn {
            border: none;
            padding: 0.75rem 2rem;
            border-radius: 10px;
            font-weight: 500;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            background: var(--button-gradient);
            color: white;
            text-transform: uppercase;
            font-size: 1rem;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(147, 51, 234, 0.3);
        }

        .btn-success {
            background: linear-gradient(120deg, #10B981 0%, #059669 100%);
        }

        /* Back button */
        .back-btn {
            position: absolute;
            top: 1rem;
            left: 1rem;
            background: var(--glass-gradient);
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding: 0.5rem 1rem;
            border-radius: 10px;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .back-btn:hover {
            transform: translateX(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            color: white;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <!-- Animated Bubbles -->
    <div class="bubbles">
        <div class="bubble"></div>
        <div class="bubble"></div>
        <div class="bubble"></div>
    </div>

    <div class="container">
        <a href="/" class="back-btn">
            <i class="fas fa-arrow-left"></i> Back to List
        </a>
        
        <h1>Edit Schedule</h1>

        <form:form action="/editSaveToDoItem" method="post" modelAttribute="todo">
            <form:input path="id" type="hidden"/>
            
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="form-group">
                        <label for="title">Title</label>
                        <form:input type="text" path="title" id="title" 
                            class="form-control" required="required" />
                    </div>

                    <div class="form-group">
                        <label for="date">Date</label>
                        <form:input type="date" path="date" id="date" 
                            class="form-control" required="required" />
                    </div>

                    <div class="form-group">
                        <label for="status">Status</label>
                        <form:input type="text" path="status" id="status" 
                            class="form-control" value="Incomplete" />
                    </div>

                    <div class="text-center mt-4">
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-save mr-2"></i> Save Changes
                        </button>
                    </div>
                </div>
            </div>
        </form:form>
    </div>

    <script th:inline="javascript">
        window.onload = function() {
            var msg = "${message}";
            console.log(msg);
            if (msg == "Edit Failure") {
                Command: toastr["error"]("Something went wrong with the edit.")
            }

            toastr.options = {
                "closeButton": true,
                "debug": false,
                "newestOnTop": false,
                "progressBar": true,
                "positionClass": "toast-top-right",
                "preventDuplicates": false,
                "showDuration": "300",
                "hideDuration": "1000",
                "timeOut": "5000",
                "extendedTimeOut": "1000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
            }
        }
    </script>
</body>
</html>
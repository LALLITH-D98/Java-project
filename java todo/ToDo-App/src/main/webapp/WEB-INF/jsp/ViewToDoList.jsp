<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>View ToDo Item List</title>
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

        .bubble:nth-child(4) {
            width: 80px;
            height: 80px;
            left: 50%;
            animation-duration: 11s;
            animation-delay: 0s;
        }

        .bubble:nth-child(5) {
            width: 35px;
            height: 35px;
            left: 55%;
            animation-duration: 6s;
            animation-delay: 1s;
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

        .table {
            background: rgba(0, 0, 0, 0.2);
            border-radius: 15px;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #fff;
            backdrop-filter: blur(5px);
        }

        .table th {
            background: rgba(147, 51, 234, 0.2);
            color: white;
            border: none;
            padding: 1rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .table td {
            border-color: rgba(255, 255, 255, 0.05);
            padding: 1rem;
            vertical-align: middle;
        }

        .btn {
            border: none;
            padding: 0.5rem 1.5rem;
            border-radius: 10px;
            transition: all 0.3s ease;
            background: var(--glass-gradient);
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .btn:hover {
            transform: translateY(-2px) scale(1.05);
            box-shadow: 0 5px 15px rgba(147, 51, 234, 0.3);
        }

        .btn-success {
            background: linear-gradient(120deg, #10B981 0%, #059669 100%);
        }

        .btn-primary {
            background: var(--button-gradient);
        }

        .btn-danger {
            background: linear-gradient(120deg, #EF4444 0%, #DC2626 100%);
        }

        .btn-block {
            background: var(--button-gradient);
            margin-top: 2rem;
            padding: 1rem;
            font-size: 1.1rem;
            font-weight: 500;
            letter-spacing: 1px;
        }

        a {
            color: white !important;
            text-decoration: none !important;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        tr {
            transition: all 0.3s ease;
            position: relative;
        }

        tr:hover {
            transform: scale(1.01);
            background: rgba(147, 51, 234, 0.1);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
            background: var(--glass-gradient);
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            display: inline-block;
        }

        /* Custom scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb {
            background: var(--button-gradient);
            border-radius: 4px;
        }

        /* Glass reflection effect */
        .container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 100%;
            background: linear-gradient(
                120deg,
                rgba(255,255,255,0.1) 0%,
                rgba(255,255,255,0.05) 50%,
                transparent 100%
            );
            border-radius: 20px;
            pointer-events: none;
        }

        
    </style>
</head>
<body>
    <!-- Animated Bubbles -->
    <div class="bubbles">
        <div class="bubble"></div>
        <div class="bubble"></div>
        <div class="bubble"></div>
        <div class="bubble"></div>
        <div class="bubble"></div>
    </div>

    <div class="container">
        <h1> Schedule management app </h1>
        <form:form>
            <table class="table">
                <tr>
                    <th>Id</th>
                    <th>Title</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Mark Completed</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>

                <c:forEach var="todo" items="${list}">
                    <tr>
                        <td>${todo.id}</td>
                        <td>${todo.title}</td>
                        <td>${todo.date}</td>
                        <td><span class="status-badge">${todo.status}</span></td>
                        <td>
                            <button type="button" class="btn btn-success">
                                <a href="/updateToDoStatus/${todo.id}">
                                    <i class="fas fa-check"></i> Complete
                                </a>
                            </button>
                        </td>
                        <td>
                            <button type="button" class="btn btn-primary">
                                <a href="/editToDoItem/${todo.id}">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                            </button>
                        </td>
                        <td>
                            <button type="button" class="btn btn-danger" onclick=alert("deleted")>
                                <a href="/deleteToDoItem/${todo.id}">
                                    <i class="fas fa-trash"></i> Delete
                                </a>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </form:form>

        <button type="button" class="btn btn-primary btn-block">
            <a href="/addToDoItem">
                <i class="fas fa-plus"></i> Add New Schedule
            </a>
        </button>
    </div>

    <script th:inline="javascript">
        window.onload = function() {
            var msg = "${message}";
            
            if (msg == "Save Success") {
                Command: toastr["success"]("Item added successfully!!")
            } else if (msg == "Delete Success") {
                Command: toastr["success"]("Item deleted successfully!!")
            } else if (msg == "Delete Failure") {
                Command: toastr["error"]("Some error occurred, couldn't delete item")
            } else if (msg == "Edit Success") {
                Command: toastr["success"]("Item updated successfully!!")
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
<%@page import="com.fptuni.prj301.assignment.model.UserSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<c:url var="loginLink" value="/Access/logout"></c:url>
<c:url var="homeLink" value="/Home/home"></c:url>
<c:url var="foodListLink" value="/Food/list"></c:url>
<c:url var="payLink" value="/Pay/pay"></c:url>


    <header class="header">
        <div class="header__left">
            <a href='${homeLink}' class='header__logo'>
            <img src="../assets/images/logo.png" alt="" class="header__logo-img">
        </a>
        <nav class="header__navigation">
            <ul class="navigation-list">
                <li class="header__navigation-item">
                    <a href='${homeLink}' class='header__navigation-item-link'>
                        <div class="header__navigation-icon">
                            <i class="fa-solid fa-house"></i>
                        </div>
                        <span class="header__navigation-content">Trang chủ</span>
                    </a>
                </li>
                <li class="header__navigation-item">
                    <a href='${foodListLink}' class='header__navigation-item-link'>
                        <div class="header__navigation-icon">
                            <i class="fa-solid fa-utensils"></i>
                        </div>
                        <span class="header__navigation-content">Đặt hàng</span>
                    </a>
                </li>
                <li class="header__navigation-item">
                    <a  class="header__navigation-item-link header__vip">
                        <div class="header__navigation-icon">
                            <i class="fa-solid fa-star"></i>
                        </div>
                        <span class="header__navigation-content">V.I.P</span>
                    </a>
                </li>
            </ul>
        </nav>
    </div>
    <div class="header__right">
        <a href="${payLink}" class="header__cart">
            <i class="fa-solid fa-cart-shopping"></i>
        </a>
        <a href="#" class="header__right-user-link">
            <div class="header__user">
                <div class="header__user-icon">
                    <i class="fa-solid fa-user"></i>
                </div>
                <jsp:useBean id="usersession" class="com.fptuni.prj301.assignment.model.UserSession" scope="session"/>
                <c:if test="${usersession != null}">
                    <span class='header__user-info inactive'>${usersession.username}</span>
                </c:if>

            </div>
        </a>
        <a href='${loginLink}' class='header__right-log-out'>
            <i class="fa-solid fa-arrow-right-from-bracket"></i>
        </a>
    </div>
</header>
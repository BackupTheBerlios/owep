<%@ page language="java" %>
<%@page import="owep.modele.execution.MCollaborateur"%>
<%@page import="owep.controle.CConstante"%>
<%@ taglib uri="/WEB-INF/tld/template.tld" prefix="template" %>
<!DOCTYPE HTML PUBLIC "-//w3c//dtd html 4.0 transitional//en">

<%
  //localisation
  java.util.ResourceBundle messages;
  messages = java.util.ResourceBundle.getBundle("MessagesBundle");
  
  MCollaborateur lCollaborateur  = (MCollaborateur) request.getAttribute (CConstante.PAR_COLLABORATEUR) ;
  String nomCollab = messages.getString("detailAvancementCollabTitre")+" "+lCollaborateur.getNom() ;
%>

<template:template nom="/JSP/Template/FTemplate.jsp">
  <template:section region="RegionTitre"      contenu="<%=nomCollab%>" typePage="false"/>
  <template:section region="RegionNavigation" contenu="/JSP/Navigation/FIteration.jsp" typePage="true"/>  
  <template:section region="RegionPrincipal"  contenu="/JSP/Avancement/FDetailAvancementCollab.jsp" typePage="true"/>
  <template:section region="RegionLogo"       contenu="/JSP/Template/FLogo.jsp"        typePage="true"/>
  <template:section region="RegionMenu"       contenu="/JSP/Template/FMenu.jsp"        typePage="true"/>
  <template:section region="RegionMessagerie" contenu="/JSP/Template/FMessagerie.jsp"  typePage="true"/>
  <template:section region="RegionPied"       contenu="/JSP/Template/FPied.jsp"        typePage="true"/>
</template:template>
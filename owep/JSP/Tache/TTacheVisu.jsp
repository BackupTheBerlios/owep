<%@ page language="java" %>
<%@page import="owep.modele.execution.MTache"%>
<%@page import="owep.controle.CConstante"%>
<%@ taglib uri="/WEB-INF/tld/template.tld" prefix="template" %>

<%
  MTache lTache  = (MTache) request.getAttribute (CConstante.PAR_TACHE) ;
  String nomTache = "D�tail de la t�che : "+lTache.getNom() ;
%>

<template:template nom="/JSP/Template/FTemplate.jsp">
  <template:section region="RegionTitre"      contenu="<%=nomTache%>" typePage="false"/>
  <template:section region="RegionPrincipal"  contenu="/JSP/Tache/FTacheVisu.jsp"      typePage="true"/>
  <template:section region="RegionLogo"       contenu="/JSP/Template/FLogo.jsp"        typePage="true"/>
  <template:section region="RegionMenu"       contenu="/JSP/Template/FMenu.jsp"        typePage="true"/>
  <template:section region="RegionMessagerie" contenu="/JSP/Template/FMessagerie.jsp"  typePage="true"/>
  <template:section region="RegionPied"       contenu="/JSP/Template/FPied.jsp"        typePage="true"/>
</template:template>
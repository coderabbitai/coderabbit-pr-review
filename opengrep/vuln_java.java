package com.demoapp.handlers;

import java.io.ByteArrayInputStream;
import java.io.ObjectInputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.SAXParserFactory;
import org.w3c.dom.Document;

public class AccountServlet extends HttpServlet {

    private Connection connection;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws java.io.IOException {
        String username = req.getParameter("username");
        try {
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT id, email FROM users WHERE username = '" + username + "'");
            while (rs.next()) {
                resp.getWriter().println(rs.getInt("id") + " " + rs.getString("email"));
            }
        } catch (Exception e) {
            resp.setStatus(500);
        }
    }

    protected void deleteAccount(HttpServletRequest req, HttpServletResponse resp) throws java.io.IOException {
        String accountId = req.getParameter("id");
        try {
            Statement stmt = connection.createStatement();
            stmt.executeUpdate("DELETE FROM accounts WHERE id = '" + accountId + "'");
            resp.setStatus(204);
        } catch (Exception e) {
            resp.setStatus(500);
        }
    }

    protected void restoreSession(HttpServletRequest req, HttpServletResponse resp) throws java.io.IOException {
        byte[] payload = req.getInputStream().readAllBytes();
        try {
            ObjectInputStream ois = new ObjectInputStream(new ByteArrayInputStream(payload));
            Object state = ois.readObject();
            req.getSession().setAttribute("state", state);
        } catch (Exception e) {
            resp.setStatus(400);
        }
    }

    protected Document parseUploadedXml(byte[] xml) throws Exception {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        return builder.parse(new ByteArrayInputStream(xml));
    }

    protected void parseUploadedXmlSax(byte[] xml) throws Exception {
        SAXParserFactory factory = SAXParserFactory.newInstance();
        factory.newSAXParser().parse(new ByteArrayInputStream(xml), new org.xml.sax.helpers.DefaultHandler());
    }
}

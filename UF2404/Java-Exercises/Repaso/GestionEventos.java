package com.mycompany.gestioneventos;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;



public class GestionEventos extends JFrame implements ActionListener, MouseListener {

    private JButton boton;
    private JLabel etiqueta;

    public GestionEventos() {
        // Configuración de la ventana
        this.setTitle("Gestión de eventos en Java");
        this.setSize(400, 300);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        // Inicialización de componentes
        boton = new JButton("Haz clic aquí");
        etiqueta = new JLabel("Esperando acción...");

        // Agregar escuchadores de eventos
        boton.addActionListener(this);  // Registra ActionListener para manejar clics
        this.addMouseListener(this);    // Registra MouseListener para manejar eventos del ratón

        // Configuración del layout y adición de componentes
        this.setLayout(new FlowLayout());
        this.add(boton);
        this.add(etiqueta);
    }

    // Método que maneja los eventos de clic en el botón
    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == boton) {
            etiqueta.setText("Botón clicado.");
        }
    }

    // Métodos que manejan los eventos del ratón
    @Override
    public void mouseClicked(MouseEvent e) {
        etiqueta.setText("Ratón clicado en la ventana.");
    }

    @Override
    public void mouseEntered(MouseEvent e) {
        etiqueta.setText("Ratón entró en la ventana.");
    }

    @Override
    public void mouseExited(MouseEvent e) {
        etiqueta.setText("Ratón salió de la ventana.");
    }

    @Override
    public void mousePressed(MouseEvent e) {}

    @Override
    public void mouseReleased(MouseEvent e) {}

    // Método principal para ejecutar el ejemplo
    public static void main(String[] args) {
        GestionEventos ventana = new GestionEventos();
        ventana.setVisible(true);
    }
}
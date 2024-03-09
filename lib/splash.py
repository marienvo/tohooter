from PySide6.QtWidgets import QSplashScreen
from PySide6.QtGui import QPixmap, QFont, QPainter, QColor, QPen
from PySide6.QtCore import Qt

def layout_and_paint(splash, pixmap, title, subtitle, details):
    # Set up the painter
    painter = QPainter(pixmap)
    painter.setRenderHint(QPainter.Antialiasing)

    # Draw the background image
    painter.drawPixmap(0, 0, pixmap.width(), pixmap.height(), splash.pixmap())

    # Set the font size and font for the title
    title_font_size = 20
    title_font = QFont()
    title_font.setPointSize(title_font_size)
    title_font.setBold(True)

    # Set the font size and font for the subtitle
    subtitle_font_size = 16
    subtitle_font = QFont()
    subtitle_font.setPointSize(subtitle_font_size)

    # Set the font size and font for the additional text
    additional_text_font_size = 12
    additional_text_font = QFont()
    additional_text_font.setPointSize(additional_text_font_size)

    # Set the main text color
    text_color = QColor(Qt.white)

    # Set the shadow color
    shadow_color = QColor(Qt.black)
    shadow_color.setAlpha(128)  # Adjust transparency for the shadow

    # Set up the pen for the shadow
    painter.setPen(QPen(shadow_color))

    # Calculate the offset for the shadow
    shadow_offset = title_font_size // 10

    # Draw the shadow of the title
    painter.setFont(title_font)
    text_rect = pixmap.rect().adjusted(20 + shadow_offset, 20 + shadow_offset, 0, -pixmap.height() // 2)
    painter.drawText(text_rect, Qt.AlignTop | Qt.AlignLeft, title)

    # Set up the pen for the main title text
    painter.setPen(QPen(text_color))

    # Draw the main title text
    text_rect = pixmap.rect().adjusted(20, 20, 0, -pixmap.height() // 2)
    painter.drawText(text_rect, Qt.AlignTop | Qt.AlignLeft, title)

    # Draw the shadow of the subtitle
    painter.setPen(QPen(shadow_color))  # Set the pen color back to shadow color
    subtitle_font.setPointSize(subtitle_font_size)  # Adjust font size for the subtitle
    painter.setFont(subtitle_font)
    text_rect = pixmap.rect().adjusted(20 + shadow_offset, 60 + shadow_offset, 0, -pixmap.height() // 2)
    painter.drawText(text_rect, Qt.AlignTop | Qt.AlignLeft, subtitle)

    # Set up the pen for the main text of the subtitle
    painter.setPen(QPen(text_color))  # Set the pen color back to text color
    text_rect = pixmap.rect().adjusted(20, 60, 0, -pixmap.height() // 2)
    painter.drawText(text_rect, Qt.AlignTop | Qt.AlignLeft, subtitle)

    # Draw the additional text at the bottom left
    additional_text = details
    additional_text_font.setPointSize(additional_text_font_size)  # Adjust font size for the additional text
    painter.setFont(additional_text_font)
    text_rect = pixmap.rect().adjusted(20, pixmap.height() - 20 - additional_text_font_size, 0, 0)
    painter.drawText(text_rect, Qt.AlignTop | Qt.AlignLeft, additional_text)

    # End painting
    painter.end()

def create_splash(title, subtitle, details):
    # Create the splash screen instance with the image
    splash = QSplashScreen(QPixmap('splash.png'), Qt.WindowStaysOnTopHint)

    # Create a pixmap for drawing the text
    pixmap = QPixmap(splash.size())
    pixmap.fill(Qt.transparent)

    # Layout and paint the title, subtitle, and additional text
    layout_and_paint(splash, pixmap, title, subtitle, details)

    # Set the pixmap with both lines of text and the background image as the splash screen
    splash.setPixmap(pixmap)

    return splash

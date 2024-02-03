package models

import "time"

type ChatMessage struct {
	ID        uint64    `gorm:"column:id"`
	ChatID    uint64    `gorm:"column:chat_id"`
	SenderID  uint64    `gorm:"column:sender_id"`
	Content   string    `gorm:"column:content"`
	CreatedAt time.Time `gorm:"column:created_at"`
}

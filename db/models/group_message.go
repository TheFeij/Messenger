package models

import "time"

type GroupMessage struct {
	ID        uint64    `gorm:"column:id"`
	GroupID   uint64    `gorm:"column:group_id"`
	SenderID  uint64    `gorm:"column:sender_id"`
	Content   string    `gorm:"column:content"`
	CreatedAt time.Time `gorm:"column:created_at"`
}

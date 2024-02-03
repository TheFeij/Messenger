package models

import "time"

type ChannelPost struct {
	ID        uint64    `gorm:"column:id"`
	ChannelID uint64    `gorm:"column:channel_id"`
	AuthorID  uint64    `gorm:"column:author_id"`
	Content   string    `gorm:"column:content"`
	CreatedAt time.Time `gorm:"column:created_at"`
}

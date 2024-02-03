package models

import "time"

type Channel struct {
	ID        uint64    `gorm:"column:id"`
	OwnerID   uint64    `gorm:"column:owner_id"`
	Name      string    `gorm:"column:name"`
	CreatedAt time.Time `gorm:"column:created_at"`
}
